
using System;

namespace Sofia.Core.Commands
{
	
	public interface ICommand
	{
		/// <summary>
		/// Execute la commande
		/// </summary>
		/// <param name="parameters">Parametres au format XML</param>
		void Execute(string parameters);

        /// <summary>
        /// Annuler la commande
        /// </summary>
		void UnExecute();
		
		/// <summary>
		/// Identifiant de la commande
		/// </summary>
		string Id  { 
			get; 
		}
		
		/// <summary>
		/// Propriétés de la commande
		/// </summary>
		CommandProperties Properties {
			get;
		}
		
        /// <summary>
        /// Gestionnaire de commande
        /// </summary>
		CommandManager Manager {
			get;
			set;
		}
		
	}
	
}
