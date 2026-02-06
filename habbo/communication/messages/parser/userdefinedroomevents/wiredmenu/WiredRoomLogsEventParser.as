package package_203
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class WiredRoomLogsEventParser implements IMessageParser
   {
      
      private var var_215:WiredLogPage;
      
      public function WiredRoomLogsEventParser()
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
         var_215 = new WiredLogPage(param1);
         return true;
      }
      
      public function get page() : WiredLogPage
      {
         return var_215;
      }
   }
}

