using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BAL;
using BEL;
using System.Data;
using System.Data.SqlClient;
using System.Security.Principal;

namespace Call_Evalutator
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        public Information info = new Information();
        public Operation oper = new Operation();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                WindowsIdentity identity = HttpContext.Current.Request.LogonUserIdentity;
                string result = identity.Name.Substring(identity.Name.LastIndexOf('\\') + 1);

                Session["canInsert"] = oper.CheckAuthorization(result, 1).ToString();
                Session["canVisualize"] = oper.CheckAuthorization(result, 2).ToString();
                rdrBtn.Visible = Session["canVisualize"].ToString() == "Y" ? true : false;

                Session["Tabella_Eval"] = ConfigurationManager.AppSettings["CallEval"];
                Session["Tabella_AgentName"] = ConfigurationManager.AppSettings["AgentName"];
                Session["Tabella_Owner"] = ConfigurationManager.AppSettings["Owner"];
                Session["Tabella_PersonInCall"] = ConfigurationManager.AppSettings["PersonInCall"];

                Session["Tabella_cc"] = ConfigurationManager.AppSettings["cc"];
                cc_.Value = Session["Tabella_cc"].ToString();

                Session["Tabella_Body"] = ConfigurationManager.AppSettings["Body"];
                body_.Value = Session["Tabella_Body"].ToString();

                Session["Alert_mail"] = ConfigurationManager.AppSettings["msg_mail"];
                alert_mail_.Value = Session["Alert_mail"].ToString();

                var localDateTime = DateTime.Now.ToString("dd/MM/yyyy");
                date_evaluation.Value = localDateTime;

                Session["Agent_DT"] = oper.GetAgentName(Session["Tabella_AgentName"].ToString());
                agent_name.DataSource = oper.GetAgentName(Session["Tabella_AgentName"].ToString());
                agent_name.DataTextField = "agent_name";
                agent_name.DataValueField = "agent_mail";
                agent_name.DataBind();
                agent_name.Items.Insert(0, new ListItem("Select agent name", ""));

                Session["Owner_DT"] = oper.GetAgentName(Session["Tabella_Owner"].ToString());
                owner.DataSource = oper.GetEvalutationOwner(Session["Tabella_Owner"].ToString());
                owner.DataTextField = "Owner";
                owner.DataValueField = "Owner";
                owner.DataBind();
                owner.Items.Insert(0, new ListItem("Select the owner", ""));

                Session["PersonCall_DT"] = oper.GetAgentName(Session["Tabella_PersonInCall"].ToString());
                call_person.DataSource = oper.GetPersonInCall(Session["Tabella_PersonInCall"].ToString());
                call_person.DataTextField = "PersonInCall";
                call_person.DataValueField = "PersonInCall";
                call_person.DataBind();
                call_person.Items.Insert(0, new ListItem("Select a person", ""));

                GrvDatiBind();
            }
        }

        protected void grvDati_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string id = grvDati.DataKeys[e.RowIndex]["Id"].ToString();
            WindowsIdentity identity = HttpContext.Current.Request.LogonUserIdentity;

            int result = oper.DeleteDataFromProcedure(Convert.ToInt32(id),identity.Name);
            if (result == 1)
            {
                ClientScript.RegisterStartupScript
                        (GetType(), Guid.NewGuid().ToString(), "AlertSuccessDelete();", true);
            }
            else
            {
                ClientScript.RegisterStartupScript
                        (GetType(), Guid.NewGuid().ToString(), "AlertFailedDelete();", true);
            }
            GrvDatiBind();
        }

        protected void grvDati_RowEditing(object sender, GridViewEditEventArgs e)
        {
            grvDati.EditIndex = e.NewEditIndex;
            GrvDatiBind();
            DropDownList dl = (DropDownList)grvDati.Rows[e.NewEditIndex].FindControl("ddlAgentName");
            dl.Enabled = true;
            //DATE EVALUTATION
            TextBox txtDateEvalutation = (grvDati.Rows[e.NewEditIndex].FindControl("txtDE") as TextBox);
            txtDateEvalutation.Enabled = true;
            //CALL DATE
            TextBox txtCallDate = (grvDati.Rows[e.NewEditIndex].FindControl("txtCD") as TextBox);
            txtCallDate.Enabled = true;
            //OWNER
            DropDownList ddlOwner = (DropDownList)grvDati.Rows[e.NewEditIndex].FindControl("ddlOwner");
            ddlOwner.Enabled = true;
            //PERSON IN CALL
            DropDownList ddlPersonCall = (DropDownList)grvDati.Rows[e.NewEditIndex].FindControl("ddlPersonCall");
            ddlPersonCall.Enabled = true;

        }


        protected void grvDati_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grvDati.PageIndex = e.NewPageIndex;
            GrvDatiBind();
        }
        protected void grvDati_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            grvDati.EditIndex = -1;
            GrvDatiBind();
        }

        public void GrvDatiBind()
        {
            DataTable dt = new DataTable();
            Session["GridData"] = oper.GetGridData();
            //if (((DataTable)Session["GridData"]).Rows.Count > 0)
            //{
                grvDati.DataSource = (DataTable)Session["GridData"];
                grvDati.DataBind();
            divGrv.Visible = true;
            //}
        }
        protected void confirm_button_Click(object sender, EventArgs e)
        {
            if(Session["canInsert"].ToString() == "N" || string.IsNullOrEmpty(Session["canInsert"].ToString()))
            {
                ClientScript.RegisterStartupScript
                    (GetType(), Guid.NewGuid().ToString(), "NotAuthorizedToInsert();", true);
                return;
            }
            info.agent_name = agent_name.Items[agent_name.SelectedIndex].Text;
            info.case_number = case_number.Value;
            DateTime dateTime = new DateTime();
            dateTime = Convert.ToDateTime(date_evaluation.Value);
            info.date_evaluation = dateTime.ToString("yyyy-MM-dd");
            info.owner = owner.Items[owner.SelectedIndex].Text;
            info.call_person = call_person.Items[call_person.SelectedIndex].Text;
            if (Convert.ToDateTime(call_date.Value) > DateTime.UtcNow)
            {
                return;
            }
            else
            {
                info.call_date = call_date.Value;
            }
            info.input_score1 = input_score1.Value;
            info.input_score2 = input_score2.Value;
            info.input_score3 = input_score3.Value;
            info.input_score4 = input_score4.Value;
            info.input_score5 = input_score5.Value;
            info.input_score6 = input_score6.Value;
            info.input_score7 = input_score7.Value;
            info.input_score8 = input_score8.Value;
            info.input_score9 = input_score9.Value;
            info.input_score10 = input_score10.Value;
            info.input_score11 = input_score11.Value;
            info.input_score12 = input_score12.Value;
            info.input_score13 = input_score13.Value;
            info.input_score14 = input_score14.Value;
            info.input_score15 = input_score15.Value;
            info.input_score16 = input_score16.Value;
            info.input_score17 = input_score17.Value;
            info.input_score18 = input_score18.Value;
            info.flg_rcn = "Y";
            info.last_modifier = "";

            Session["ChartDate"] = oper.GetSpecificJobMacroArea();

            //int result = oper.(info, Session["Tabella_Eval"].ToString());

            int result = oper.InsertCallProcedure(info);
            if (result == 1)
            {
                ClientScript.RegisterStartupScript
                        (GetType(), Guid.NewGuid().ToString(), "AlertSuccess();", true);
            }
            else
            {
                ClientScript.RegisterStartupScript
                        (GetType(), Guid.NewGuid().ToString(), "AlertFailed();", true);
            }
        }

        protected void GrvDati_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //AGENT
                DropDownList ddlAgent = (e.Row.FindControl("ddlAgentName") as DropDownList);
                ddlAgent.DataSource = ((DataTable)Session["Agent_DT"]);
                ddlAgent.DataTextField = "agent_name";
                ddlAgent.DataValueField = "agent_mail";
                ddlAgent.DataBind();
                ddlAgent.Items.Insert(0, new ListItem("Select agent name", ""));
                ddlAgent.Enabled = false;
                DataRowView dr = (DataRowView)e.Row.DataItem;
                string field1 = dr["agent_name"].ToString();
                ddlAgent.Items.FindByText(field1).Selected = true;
                //DATE EVALUTATION
                TextBox txtDateEvalutation = (e.Row.FindControl("txtDE") as TextBox);
                txtDateEvalutation.Enabled = false;
                //CALL DATE
                TextBox txtCallDate = (e.Row.FindControl("txtCD") as TextBox);
                txtCallDate.Enabled = false;
                //OWNER
                DropDownList ddlOwner = (e.Row.FindControl("ddlOwner") as DropDownList);
                ddlOwner.DataSource = ((DataTable)Session["Owner_DT"]);
                ddlOwner.DataTextField = "Owner";
                ddlOwner.DataValueField = "Owner";
                ddlOwner.DataBind();
                ddlOwner.Items.Insert(0, new ListItem("Select the owner", ""));
                ddlOwner.Enabled = false;
                DataRowView dr1 = (DataRowView)e.Row.DataItem;
                string field2 = dr1["owner"].ToString();
                ddlOwner.Items.FindByText(field2).Selected = true;
                //PERSON CALL
                DropDownList ddlPersonCall = (e.Row.FindControl("ddlPersonCall") as DropDownList);
                ddlPersonCall.DataSource = ((DataTable)Session["PersonCall_DT"]);
                ddlPersonCall.DataTextField = "PersonInCall";
                ddlPersonCall.DataValueField = "PersonInCall";
                ddlPersonCall.DataBind();
                ddlPersonCall.Items.Insert(0, new ListItem("Select a person", ""));
                ddlPersonCall.Enabled = false;
                DataRowView dr2 = (DataRowView)e.Row.DataItem;
                string field3 = dr2["call_person"].ToString();
                ddlPersonCall.Items.FindByText(field3).Selected = true;

            }
        }

        protected void grvDati_RowCreated(object sender, GridViewRowEventArgs e)
        {
        }

        protected void grvDati_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string id = grvDati.DataKeys[e.RowIndex]["Id"].ToString();

            WindowsIdentity identity = HttpContext.Current.Request.LogonUserIdentity;

            info = new Information();

            int rowIndex = e.RowIndex;
            int rowCount = grvDati.Rows.Count;

            GridViewRow row = (GridViewRow)grvDati.Rows[e.RowIndex];

            DropDownList dl = (DropDownList)grvDati.Rows[e.RowIndex].FindControl("ddlAgentName");
            DropDownList owner = (DropDownList)grvDati.Rows[e.RowIndex].FindControl("ddlOwner");
            DropDownList callPerson = (DropDownList)grvDati.Rows[e.RowIndex].FindControl("ddlPersonCall");
            TextBox de = (TextBox)grvDati.Rows[e.RowIndex].FindControl("txtDE");
            TextBox cd = (TextBox)grvDati.Rows[e.RowIndex].FindControl("txtCD");

            info.agent_name = dl.SelectedItem.Text;
            info.case_number = ((TextBox)grvDati.Rows[e.RowIndex].Cells[3].Controls[0]).Text;
            info.date_evaluation = de.Text;
            info.owner = owner.SelectedItem.Text;
            if (Convert.ToDateTime(cd.Text) > DateTime.UtcNow)
            {
                return;
            }
            else
            {
                info.call_date = cd.Text;
            }
            info.call_person = callPerson.SelectedItem.Text;
            info.input_score1 = ((TextBox)grvDati.Rows[e.RowIndex].Cells[8].Controls[0]).Text;
            info.input_score2 = ((TextBox)grvDati.Rows[e.RowIndex].Cells[9].Controls[0]).Text;
            info.input_score3 = ((TextBox)grvDati.Rows[e.RowIndex].Cells[10].Controls[0]).Text;
            info.input_score4 = ((TextBox)grvDati.Rows[e.RowIndex].Cells[11].Controls[0]).Text;
            info.input_score5 = ((TextBox)grvDati.Rows[e.RowIndex].Cells[12].Controls[0]).Text;
            info.input_score6 = ((TextBox)grvDati.Rows[e.RowIndex].Cells[13].Controls[0]).Text;
            info.input_score7 = ((TextBox)grvDati.Rows[e.RowIndex].Cells[14].Controls[0]).Text;
            info.input_score8 = ((TextBox)grvDati.Rows[e.RowIndex].Cells[15].Controls[0]).Text;
            info.input_score9 = ((TextBox)grvDati.Rows[e.RowIndex].Cells[16].Controls[0]).Text;
            info.input_score10 = ((TextBox)grvDati.Rows[e.RowIndex].Cells[17].Controls[0]).Text;
            info.input_score11 = ((TextBox)grvDati.Rows[e.RowIndex].Cells[18].Controls[0]).Text;
            info.input_score12 = ((TextBox)grvDati.Rows[e.RowIndex].Cells[19].Controls[0]).Text;
            info.input_score13 = ((TextBox)grvDati.Rows[e.RowIndex].Cells[20].Controls[0]).Text;
            info.input_score14 = ((TextBox)grvDati.Rows[e.RowIndex].Cells[21].Controls[0]).Text;
            info.input_score15 = ((TextBox)grvDati.Rows[e.RowIndex].Cells[22].Controls[0]).Text;
            info.input_score16 = ((TextBox)grvDati.Rows[e.RowIndex].Cells[23].Controls[0]).Text;
            info.input_score17 = ((TextBox)grvDati.Rows[e.RowIndex].Cells[24].Controls[0]).Text;
            info.input_score18 = ((TextBox)grvDati.Rows[e.RowIndex].Cells[25].Controls[0]).Text;
            info.flg_rcn = "Y";
            info.last_modifier = identity.Name;
            info.id_modify = Convert.ToInt32(id);


            grvDati.EditIndex = -1;
            int result = oper.InsertUpdateProcedure(info);
            if (result == 1)
            {
                ClientScript.RegisterStartupScript
                        (GetType(), Guid.NewGuid().ToString(), "AlertSuccessUpdate();", true);
            }
            else
            {
                ClientScript.RegisterStartupScript
                        (GetType(), Guid.NewGuid().ToString(), "AlertFailedUpdate();", true);
            }
            GrvDatiBind();

        }

        protected void rdrBtn_Click(object sender, EventArgs e)
        {
            Server.Transfer("Visualizzazione.aspx", true);
        }
    }
}