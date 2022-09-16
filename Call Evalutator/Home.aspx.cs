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

            }
        }


        protected void confirm_button_Click(object sender, EventArgs e)
        {
            if (Session["canInsert"].ToString() == "N" || string.IsNullOrEmpty(Session["canInsert"].ToString()))
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
            info.strenght = strenght.Text;
            info.weakness = weakness.Text;
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

        protected void rdrBtn_Click(object sender, EventArgs e)
        {
            Server.Transfer("Visualizzazione.aspx", true);
        }
    }
}