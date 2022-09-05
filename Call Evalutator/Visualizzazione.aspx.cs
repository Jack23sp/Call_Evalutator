using BAL;
using BEL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Text;
using ClosedXML.Excel;
using System.Text.RegularExpressions;

namespace Call_Evalutator
{
    public partial class Visualizzazione : System.Web.UI.Page
    {
        public Information info = new Information();
        public Operation oper = new Operation();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                divGrid.Visible = false;
                divExport.Visible = false;
                WindowsIdentity identity = HttpContext.Current.Request.LogonUserIdentity;
                string result = identity.Name.Substring(identity.Name.LastIndexOf('\\') + 1);

                Session["canVisualize"] = oper.CheckAuthorization(result, 2).ToString();
                Session["canModify"] = oper.CheckAuthorization(result, 3).ToString();
                Session["canDownload"] = oper.CheckAuthorization(result, 4).ToString();


                var localDateTime = DateTime.Now.ToString("dd/MM/yyyy");
                date_evaluation.Value = localDateTime;

                Session["Agent_DT"] = oper.GetAgentName(Session["Tabella_AgentName"].ToString());
                agent_name.DataSource = oper.GetAgentName(Session["Tabella_AgentName"].ToString());
                agent_name.DataTextField = "agent_name";
                agent_name.DataValueField = "agent_name";
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
            }
        }
        protected void grvDati_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string id = grvDati.DataKeys[e.RowIndex]["Id"].ToString();
            WindowsIdentity identity = HttpContext.Current.Request.LogonUserIdentity;

            int result = oper.DeleteDataFromProcedure(Convert.ToInt32(id), identity.Name);
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
            GrvDatiBind(((Information)Session["Info"]));
        }

        protected void grvDati_RowEditing(object sender, GridViewEditEventArgs e)
        {
            grvDati.EditIndex = e.NewEditIndex;
            GrvDatiBind(((Information)Session["Info"]));
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
            GrvDatiBind(((Information)Session["Info"]));
        }
        protected void grvDati_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            grvDati.EditIndex = -1;
            GrvDatiBind(((Information)Session["Info"]));
        }

        public void GrvDatiBind(Information info)
        {
            DataTable dt = new DataTable();
            Session["GridData"] = oper.GetGridDataWithInfo(info);
            grvDati.DataSource = (DataTable)Session["GridData"];
            grvDati.DataBind();
            divGrid.Visible = true;

            if (((DataTable)Session["GridData"]).Rows.Count == 0)
            {
                divExport.Visible = true;
                imgCsv.Enabled = false;
                imgExl.Enabled = false;
            }
            else
            {
                divExport.Visible = true;
                if (Session["canDownload"].ToString() == "Y")
                {
                    imgCsv.Enabled = true;
                    imgExl.Enabled = true;
                }
                else
                {
                    imgCsv.Enabled = false;
                    imgExl.Enabled = false;
                }
            }
        }
        protected void confirm_button_Click(object sender, EventArgs e)
        {
            DateTime dateTime = new DateTime();
            info.agent_name = agent_name.Items[agent_name.SelectedIndex].Value;
            info.case_number = case_number.Value;
            if (date_evaluation.Value != string.Empty)
            {
                dateTime = Convert.ToDateTime(date_evaluation.Value);
                info.date_evaluation = dateTime.ToString("yyyy-MM-dd");
            }
            else
            {
                info.date_evaluation = date_evaluation.Value;
            }
            info.owner = owner.Items[owner.SelectedIndex].Value;
            info.call_person = call_person.Items[call_person.SelectedIndex].Value;
            if (call_date.Value != string.Empty)
            {
                dateTime = Convert.ToDateTime(call_date.Value);
                info.call_date = dateTime.ToString("yyyy-MM-dd");
            }
            else
            {
                info.call_date = call_date.Value;
            }
            Session["Info"] = info;

            if (Session["canVisualize"].ToString() == "N" || string.IsNullOrEmpty(Session["canVisualize"].ToString()))
            {
                ClientScript.RegisterStartupScript
                        (GetType(), Guid.NewGuid().ToString(), "NotAuthorizedToVisualize();", true);
                return;
            }
            else
            {
                GrvDatiBind(info);
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
                ddlAgent.DataValueField = "agent_name";
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
            if (Session["canModify"].ToString() == "N" || string.IsNullOrEmpty(Session["canModify"].ToString()))
            {
                ClientScript.RegisterStartupScript
                        (GetType(), Guid.NewGuid().ToString(), "NotAuthorizedToModify();", true);
                grvDati.EditIndex = -1;
                return;
            }
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
            info.call_date = cd.Text;            
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

            if(Convert.ToDateTime(info.call_date) > DateTime.UtcNow || Convert.ToDateTime(info.call_date) > Convert.ToDateTime(info.date_evaluation))
            {
                ClientScript.RegisterStartupScript
                        (GetType(), Guid.NewGuid().ToString(), "CallDateError();", true);
                return;
            }
            if(!CheckConsistencyData())
            {
                ClientScript.RegisterStartupScript
                    (GetType(), Guid.NewGuid().ToString(), "CheckData();", true);
                return;
            }

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
            GrvDatiBind((Information)Session["info"]);
        }

        public bool InsideRange(int value)
        {
            return value >= 0 && value <= 3; 
        }

        public bool CheckConsistencyData()
        {
            if (!InsideRange(Convert.ToInt32(info.input_score1)) ||
               !InsideRange(Convert.ToInt32(info.input_score2)) ||
               !InsideRange(Convert.ToInt32(info.input_score3)) ||
               !InsideRange(Convert.ToInt32(info.input_score4)) ||
               !InsideRange(Convert.ToInt32(info.input_score5)) ||
               !InsideRange(Convert.ToInt32(info.input_score6)) ||
               !InsideRange(Convert.ToInt32(info.input_score7)) ||
               !InsideRange(Convert.ToInt32(info.input_score8)) ||
               !InsideRange(Convert.ToInt32(info.input_score9)) ||
               !InsideRange(Convert.ToInt32(info.input_score10)) ||
               !InsideRange(Convert.ToInt32(info.input_score11)) ||
               !InsideRange(Convert.ToInt32(info.input_score12)) ||
               !InsideRange(Convert.ToInt32(info.input_score13)) ||
               !InsideRange(Convert.ToInt32(info.input_score14)) ||
               !InsideRange(Convert.ToInt32(info.input_score15)) ||
               !InsideRange(Convert.ToInt32(info.input_score16)) ||
               !InsideRange(Convert.ToInt32(info.input_score17)) ||
               !InsideRange(Convert.ToInt32(info.input_score18)))
            {
                return false;
            }
            return true;
        }

        public static string ScrubHtml(string value)
        {
            var step1 = Regex.Replace(value, @"<[^>]+>|&nbsp;", "").Trim();
            var step2 = Regex.Replace(step1, @"\s{2,}", " ");
            return step2;
        }

        public void ExportGridToExcel()
        {
            DataTable dt = new DataTable();
            dt = ((DataTable)Session["GridData"]);
            dt.Columns.RemoveAt(0);
            using (XLWorkbook wb = new XLWorkbook())
            {
                wb.Worksheets.Add(dt, "Call_Evaluation");

                Response.Clear();
                Response.Buffer = true;
                Response.Charset = "";
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", "attachment;filename=Call_Evaluation" + DateTime.Now.ToString() +".xlsx");
                using (MemoryStream MyMemoryStream = new MemoryStream())
                {
                    wb.SaveAs(MyMemoryStream);
                    MyMemoryStream.WriteTo(Response.OutputStream);
                    Response.Flush();
                    Response.End();
                }
            }
        }

        public void ExportGridToCSV()
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=Call_evaluation" + DateTime.Now.ToString() +".csv");
            Response.Charset = "";
            Response.ContentType = "application/text";
            StringBuilder sb = new StringBuilder();
            DataTable dt = Session["GridData"] as DataTable;
            // Hide/Remove columns from csv.
            dt.Columns.RemoveAt(0);// Removes the column at the specified index
            for (int k = 0; k < dt.Columns.Count; k++)
            {
                sb.Append(dt.Columns[k].ColumnName + ';');
            }
            sb.Append("\r\n");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                for (int k = 0; k < dt.Columns.Count; k++)
                {
                    sb.Append(dt.Rows[i][k].ToString().Replace(",", ";") + ';');
                }
                sb.Append("\r\n");
            }
            Response.Output.Write(sb.ToString());
            Response.Flush();
            Response.End();
        }
        
        protected void imgCsv_Click(object sender, ImageClickEventArgs e)
        {
            if (Session["canDownload"].ToString() == "N" || string.IsNullOrEmpty(Session["canDownload"].ToString()))
            {
                ClientScript.RegisterStartupScript
                        (GetType(), Guid.NewGuid().ToString(), "NotAuthorizedToDownload();", true);
                return;
            }
            ExportGridToCSV();
        }

        protected void imgExl_Click(object sender, ImageClickEventArgs e)
        {
            if (Session["canDownload"].ToString() == "N" || string.IsNullOrEmpty(Session["canDownload"].ToString()))
            {
                ClientScript.RegisterStartupScript
                        (GetType(), Guid.NewGuid().ToString(), "NotAuthorizedToDownload();", true);
                return;
            }
            ExportGridToExcel();
        }
    }
}