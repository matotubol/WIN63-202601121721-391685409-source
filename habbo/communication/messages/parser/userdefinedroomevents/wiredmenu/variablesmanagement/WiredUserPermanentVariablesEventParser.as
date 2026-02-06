package package_201
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class WiredUserPermanentVariablesEventParser implements IMessageParser
   {
      
      private var var_121:WiredUserPermanentVariablesList;
      
      public function WiredUserPermanentVariablesEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_121 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_121 = new WiredUserPermanentVariablesList(param1);
         return true;
      }
      
      public function get list() : WiredUserPermanentVariablesList
      {
         return var_121;
      }
   }
}

