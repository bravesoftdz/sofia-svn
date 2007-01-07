using System;
using System.Collections.Generic;
using System.Text;

using System.Data;

namespace Sofia.Data.Common
{
    public interface ISgbdConsts
    {
        /// <summary>
        /// Obtient la chaine de caract�re repr�sentant le type de donn�e sp�cifique � un SGBD
        /// </summary>
        /// <param name="dbType">Le type de donn�e abstrait</param>
        /// <returns></returns>
        string GetDDLString(DbType dbType);

        string GetTextBlobString();
    }
}
