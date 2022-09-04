using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using BEL;

namespace DAL
{
    public class DBConnection
    {
        public SqlConnection con = new SqlConnection("Data Source=DESKTOP-FQA8OA3\\SQLEXPRESS;Integrated Security=True");

        public SqlConnection GetConnection()
        {
            if (con.State == ConnectionState.Closed)
            {
                con.Open();
            }
            return con;
        }

        public int ExeNonQuery(SqlCommand cmd)
        {
            cmd.Connection = GetConnection();
            int rowAffected = -1;
            rowAffected = cmd.ExecuteNonQuery();
            con.Close();
            return rowAffected;
        }

        public object ExeScalar(SqlCommand cmd)
        {
            cmd.Connection = GetConnection();
            Object obj = -1;
            obj = cmd.ExecuteScalar();
            con.Close();
            return obj;
        }

        public DataTable ExeReader(SqlCommand cmd)
        {
            cmd.Connection = GetConnection();
            SqlDataReader sdr;
            DataTable dt = new DataTable();

            sdr = cmd.ExecuteReader();
            dt.Load(sdr);
            return dt;
        }

        public int ExecuteProcedureInsert(Information info)
        {
            SqlCommand cmd = new SqlCommand("InsertCallEval", con);
            cmd.Connection = GetConnection();
            cmd.CommandType = CommandType.StoredProcedure;
            DataTable dt = new DataTable();
            cmd.Parameters.AddWithValue("@agent_name", SqlDbType.VarChar).Value = info.agent_name;
            cmd.Parameters.AddWithValue("@case_number", SqlDbType.VarChar).Value = info.case_number;
            cmd.Parameters.AddWithValue("@date_evaluation", SqlDbType.VarChar).Value = info.date_evaluation;
            cmd.Parameters.AddWithValue("@owner", SqlDbType.VarChar).Value = info.owner;
            cmd.Parameters.AddWithValue("@call_date", SqlDbType.VarChar).Value = info.call_date;
            cmd.Parameters.AddWithValue("@call_person", SqlDbType.VarChar).Value = info.call_person;
            cmd.Parameters.AddWithValue("@input_score1", SqlDbType.Int).Value = info.input_score1;
            cmd.Parameters.AddWithValue("@input_score2", SqlDbType.Int).Value = info.input_score2;
            cmd.Parameters.AddWithValue("@input_score3", SqlDbType.Int).Value = info.input_score3;
            cmd.Parameters.AddWithValue("@input_score4", SqlDbType.Int).Value = info.input_score4;
            cmd.Parameters.AddWithValue("@input_score5", SqlDbType.Int).Value = info.input_score5;
            cmd.Parameters.AddWithValue("@input_score6", SqlDbType.Int).Value = info.input_score6;
            cmd.Parameters.AddWithValue("@input_score7", SqlDbType.Int).Value = info.input_score7;
            cmd.Parameters.AddWithValue("@input_score8", SqlDbType.Int).Value = info.input_score8;
            cmd.Parameters.AddWithValue("@input_score9", SqlDbType.Int).Value = info.input_score9;
            cmd.Parameters.AddWithValue("@input_score10", SqlDbType.Int).Value = info.input_score10;
            cmd.Parameters.AddWithValue("@input_score11", SqlDbType.Int).Value = info.input_score11;
            cmd.Parameters.AddWithValue("@input_score12", SqlDbType.Int).Value = info.input_score12;
            cmd.Parameters.AddWithValue("@input_score13", SqlDbType.Int).Value = info.input_score13;
            cmd.Parameters.AddWithValue("@input_score14", SqlDbType.Int).Value = info.input_score14;
            cmd.Parameters.AddWithValue("@input_score15", SqlDbType.Int).Value = info.input_score15;
            cmd.Parameters.AddWithValue("@input_score16", SqlDbType.Int).Value = info.input_score16;
            cmd.Parameters.AddWithValue("@input_score17", SqlDbType.Int).Value = info.input_score17;
            cmd.Parameters.AddWithValue("@input_score18", SqlDbType.Int).Value = info.input_score18;
            cmd.Parameters.AddWithValue("@flg_rcn", SqlDbType.VarChar).Value = info.flg_rcn;
            cmd.Parameters.AddWithValue("@last_modifier", SqlDbType.VarChar).Value = info.last_modifier;
            SqlParameter error = new SqlParameter();
            error.ParameterName = "@error";
            error.DbType = DbType.Int32;
            error.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(error);
            ExeNonQuery(cmd);
            return Convert.ToInt32(cmd.Parameters["@error"].Value);
        }
        public int ExecuteProcedureUpdate(Information info)
        {
            SqlCommand cmd = new SqlCommand("UpdateData", con);
            cmd.Connection = GetConnection();
            cmd.CommandType = CommandType.StoredProcedure;
            DataTable dt = new DataTable();
            cmd.Parameters.AddWithValue("@idModify", SqlDbType.Int).Value = info.id_modify;
            cmd.Parameters.AddWithValue("@agent_name", SqlDbType.VarChar).Value = info.agent_name;
            cmd.Parameters.AddWithValue("@case_number", SqlDbType.VarChar).Value = info.case_number;
            cmd.Parameters.AddWithValue("@date_evaluation", SqlDbType.VarChar).Value = info.date_evaluation;
            cmd.Parameters.AddWithValue("@owner", SqlDbType.VarChar).Value = info.owner;
            cmd.Parameters.AddWithValue("@call_date", SqlDbType.VarChar).Value = info.call_date;
            cmd.Parameters.AddWithValue("@call_person", SqlDbType.VarChar).Value = info.call_person;
            cmd.Parameters.AddWithValue("@input_score1", SqlDbType.Int).Value = info.input_score1;
            cmd.Parameters.AddWithValue("@input_score2", SqlDbType.Int).Value = info.input_score2;
            cmd.Parameters.AddWithValue("@input_score3", SqlDbType.Int).Value = info.input_score3;
            cmd.Parameters.AddWithValue("@input_score4", SqlDbType.Int).Value = info.input_score4;
            cmd.Parameters.AddWithValue("@input_score5", SqlDbType.Int).Value = info.input_score5;
            cmd.Parameters.AddWithValue("@input_score6", SqlDbType.Int).Value = info.input_score6;
            cmd.Parameters.AddWithValue("@input_score7", SqlDbType.Int).Value = info.input_score7;
            cmd.Parameters.AddWithValue("@input_score8", SqlDbType.Int).Value = info.input_score8;
            cmd.Parameters.AddWithValue("@input_score9", SqlDbType.Int).Value = info.input_score9;
            cmd.Parameters.AddWithValue("@input_score10", SqlDbType.Int).Value = info.input_score10;
            cmd.Parameters.AddWithValue("@input_score11", SqlDbType.Int).Value = info.input_score11;
            cmd.Parameters.AddWithValue("@input_score12", SqlDbType.Int).Value = info.input_score12;
            cmd.Parameters.AddWithValue("@input_score13", SqlDbType.Int).Value = info.input_score13;
            cmd.Parameters.AddWithValue("@input_score14", SqlDbType.Int).Value = info.input_score14;
            cmd.Parameters.AddWithValue("@input_score15", SqlDbType.Int).Value = info.input_score15;
            cmd.Parameters.AddWithValue("@input_score16", SqlDbType.Int).Value = info.input_score16;
            cmd.Parameters.AddWithValue("@input_score17", SqlDbType.Int).Value = info.input_score17;
            cmd.Parameters.AddWithValue("@input_score18", SqlDbType.Int).Value = info.input_score18;
            cmd.Parameters.AddWithValue("@flg_rcn", SqlDbType.Int).Value = info.flg_rcn;
            cmd.Parameters.AddWithValue("@last_modifier", SqlDbType.VarChar).Value = info.last_modifier;
            SqlParameter error = new SqlParameter();
            error.ParameterName = "@error";
            error.DbType = DbType.Int32;
            error.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(error);
            ExeNonQuery(cmd);
            return Convert.ToInt32(cmd.Parameters["@error"].Value);
        }

        public int ExecuteProcedureDelete(int id_modify, string last_modifier)
        {
            SqlCommand cmd = new SqlCommand("DeleteData", con);
            cmd.Connection = GetConnection();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@idModify", SqlDbType.Int).Value = id_modify;
            cmd.Parameters.AddWithValue("@last_modifier", SqlDbType.VarChar).Value = last_modifier;
            SqlParameter error = new SqlParameter();
            error.ParameterName = "@error";
            error.DbType = DbType.Int32;
            error.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(error);
            ExeNonQuery(cmd);
            return Convert.ToInt32(cmd.Parameters["@error"].Value);
        }



        public DataTable ExecuteProcedureJobMacro()
        {
            SqlCommand cmd = new SqlCommand("DisplayDataChart",con);
            cmd.Connection = GetConnection();
            cmd.CommandType = CommandType.StoredProcedure;
            DataTable dt = new DataTable();
            cmd.Parameters.AddWithValue("@agent", SqlDbType.VarChar).Value = "Elia Ambrosino";
            cmd.Parameters.AddWithValue("@months", SqlDbType.Int).Value = 0;
            cmd.Parameters.AddWithValue("@argument", SqlDbType.Int).Value = 4;
            return ExeReader(cmd);
            
        }
        public DataTable ExecuteProcedureGridData()
        {
            SqlCommand cmd = new SqlCommand("DisplayData", con);
            cmd.Connection = GetConnection();
            cmd.CommandType = CommandType.StoredProcedure;
            DataTable dt = new DataTable();
            cmd.Parameters.AddWithValue("@agent", SqlDbType.VarChar).Value = "Elia Ambrosino";
            cmd.Parameters.AddWithValue("@months", SqlDbType.Int).Value = 9;
            return ExeReader(cmd);
        }

        public DataTable ExecuteProcedureGridDataWithInfo(Information info)
        {
            SqlCommand cmd = new SqlCommand("DisplayDataFromInfo", con);
            cmd.Connection = GetConnection();
            cmd.CommandType = CommandType.StoredProcedure;
            DataTable dt = new DataTable();
            cmd.Parameters.AddWithValue("@agent_name", SqlDbType.VarChar).Value = info.agent_name;
            cmd.Parameters.AddWithValue("@case_number", SqlDbType.VarChar).Value = info.case_number;
            cmd.Parameters.AddWithValue("@date_evaluation", SqlDbType.VarChar).Value = info.date_evaluation;
            cmd.Parameters.AddWithValue("@owner", SqlDbType.VarChar).Value = info.owner;
            cmd.Parameters.AddWithValue("@call_date", SqlDbType.VarChar).Value = info.call_date;
            cmd.Parameters.AddWithValue("@call_person", SqlDbType.VarChar).Value = info.call_person;
            return ExeReader(cmd);
        }

        public string ExecuteProcedureCheckAuthorization(string user, int authorizationType)
        {
            SqlCommand cmd = new SqlCommand("CheckUserAuth", con);
            cmd.Connection = GetConnection();
            cmd.CommandType = CommandType.StoredProcedure;
            DataTable dt = new DataTable();
            cmd.Parameters.AddWithValue("@user", SqlDbType.VarChar).Value = user;
            cmd.Parameters.AddWithValue("@authorizationType", SqlDbType.Int).Value = authorizationType;
            SqlParameter error = new SqlParameter();
            error.ParameterName = "@authorized";
            error.DbType = DbType.String;
            error.Direction = ParameterDirection.Output;
            error.Size = 1;
            cmd.Parameters.Add(error);
            ExeNonQuery(cmd);
            return cmd.Parameters["@authorized"].Value.ToString();
        }


        public DataTable ExecuteRecordUpdate(string username,int id)
        {
            SqlCommand cmd = new SqlCommand("UpdateData", con);
            cmd.Connection = GetConnection();
            cmd.CommandType = CommandType.StoredProcedure;
            DataTable dt = new DataTable();
            cmd.Parameters.AddWithValue("@userModify", SqlDbType.VarChar).Value = username;
            cmd.Parameters.AddWithValue("@idModify", SqlDbType.Int).Value = id;
            return ExeReader(cmd);

        }
    }
}
