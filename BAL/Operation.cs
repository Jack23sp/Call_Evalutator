using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL;
using BEL;
using System.Data;
using System.Data.SqlClient;

namespace BAL
{
    public class Operation
    {
        public DBConnection connection = new DBConnection();
        public Information info = new Information();

        public int InsertCall(Information info)
        {   
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "INSERT INTO CallEval VALUES ('"+ info.agent_name + "' , '" + info.case_number + "', '" + info.date_evaluation + "', '" + info.owner + "', '" + info.call_date + "', '" + info.call_person + "', '" + info.input_score1 + "', '" + info.input_score2 + "', '" + info.input_score3 + "', '" + info.input_score4 + "', '" + info.input_score5 + "', '" + info.input_score6 + "', '" + info.input_score7 + "', '" + info.input_score8 + "', '" + info.input_score9 + "', '" + info.input_score10 + "', '" + info.input_score11 + "', '" + info.input_score12 + "', '" + info.input_score13 + "', '" + info.input_score14 + "', '" + info.input_score15 + "', '" + info.input_score16 + "', '" + info.input_score17 + "', '" + info.input_score18 + "')";
            return connection.ExeNonQuery(cmd);
        }

        public DataTable GetAgentName()
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM Agent_name";
            return connection.ExeReader(cmd);
        }

        public DataTable GetEvalutationOwner()
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM Owner";
            return connection.ExeReader(cmd);
        }

        public DataTable GetPersonInCall()
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM PersonInCall";
            return connection.ExeReader(cmd);
        }


    }
}
