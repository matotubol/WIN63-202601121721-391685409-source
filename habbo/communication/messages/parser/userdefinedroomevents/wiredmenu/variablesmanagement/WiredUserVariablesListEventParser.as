package package_201
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class WiredUserVariablesListEventParser implements IMessageParser
   {
      
      private var var_215:WiredUserVariablesPage;
      
      public function WiredUserVariablesListEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_215 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_215 = new WiredUserVariablesPage(param1);
         return true;
      }
      
      public function get page() : WiredUserVariablesPage
      {
         return var_215;
      }
   }
}

