using System;
using System.Collections.Generic;
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

        }

        protected void confirm_button_Click(object sender, EventArgs e)
        {
            info.agent_name = agent_name.Value;
            info.case_number = case_number.Value;
            info.date_evaluation = Convert.ToDateTime(date_evaluation.Value);
            info.owner = owner.Value;
            info.call_person = call_person.Value;
            info.call_date = Convert.ToDateTime(call_date.Value);
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

            int result = oper.InsertCall(info);
            if(result == 1)
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