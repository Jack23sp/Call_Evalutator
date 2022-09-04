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

        public DataTable GetAgentName(string table)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM " + table;
            return connection.ExeReader(cmd);
        }

        public DataTable GetEvalutationOwner(string table)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM " + table;
            return connection.ExeReader(cmd);
        }

        public DataTable GetPersonInCall(string table)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM " + table;
            return connection.ExeReader(cmd);
        }

        public DataTable GetSpecificJobMacroArea()
        {
            return connection.ExecuteProcedureJobMacro();
        }
        public DataTable GetGridData()
        {
            return connection.ExecuteProcedureGridData();
        }

        public DataTable GetGridDataWithInfo(Information info)
        {
            return connection.ExecuteProcedureGridDataWithInfo(info);
        }

        public int InsertCallProcedure(Information info)
        {
            return connection.ExecuteProcedureInsert(info);
        }

        public int InsertUpdateProcedure(Information info)
        {
            return connection.ExecuteProcedureUpdate(info);
        }

        public string CheckAuthorization(string user, int auth_type)
        {
            return connection.ExecuteProcedureCheckAuthorization(user, auth_type);
        }

        public int DeleteDataFromProcedure(int id, string last_modifier)
        {
            return connection.ExecuteProcedureDelete(id, last_modifier);
        }

        public int DeleteRecord(string table, int id)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "UPDATE " + table + " SET flg_rcn = N WHERE id = " + id;
            return connection.ExeNonQuery(cmd);
        }
    }
}
