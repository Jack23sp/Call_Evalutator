using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

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

    }
}
