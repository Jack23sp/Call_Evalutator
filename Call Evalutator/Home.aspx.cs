using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BAL;
using BEL;

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

                agent_name.DataSource = oper.GetAgentName(Session["Tabella_AgentName"].ToString());
                agent_name.DataTextField = "agent_name";
                agent_name.DataValueField = "agent_mail";
                agent_name.DataBind();
                agent_name.Items.Insert(0, new ListItem("Select agent name", ""));

                owner.DataSource = oper.GetEvalutationOwner(Session["Tabella_Owner"].ToString());
                owner.DataTextField = "Owner";
                owner.DataValueField = "Owner";
                owner.DataBind();
                owner.Items.Insert(0, new ListItem("Select the owner", ""));

                call_person.DataSource = oper.GetPersonInCall(Session["Tabella_PersonInCall"].ToString());
                call_person.DataTextField = "PersonInCall";
                call_person.DataValueField = "PersonInCall";
                call_person.DataBind();
                call_person.Items.Insert(0, new ListItem("Select a person", ""));
            }
        }

        protected void confirm_button_Click(object sender, EventArgs e)
        {
            info.agent_name = agent_name.Items[agent_name.SelectedIndex].Text;
            info.case_number = case_number.Value;
            info.date_evaluation = Convert.ToDateTime(date_evaluation.Value);
            info.owner = owner.Items[agent_name.SelectedIndex].Text;
            info.call_person = call_person.Items[agent_name.SelectedIndex].Text;
            if (Convert.ToDateTime(call_date.Value) > DateTime.UtcNow)
            {
                return;
            }
            else
            {
                info.call_date = Convert.ToDateTime(call_date.Value);
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

            int result = oper.InsertCall(info, Session["Tabella_Eval"].ToString());
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
    }
}