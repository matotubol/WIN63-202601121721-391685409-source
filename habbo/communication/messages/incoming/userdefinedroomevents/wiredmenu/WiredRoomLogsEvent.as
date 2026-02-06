package package_172
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import package_203.WiredRoomLogsEventParser;
   
   [SecureSWF(rename="true")]
   public class WiredRoomLogsEvent extends MessageEvent implements IMessageEvent
   {
      
      public function WiredRoomLogsEvent(param1:Function)
      {
         super(param1,WiredRoomLogsEventParser);
      }
      
      public function getParser() : WiredRoomLogsEventParser
      {
         return this.var_15 as WiredRoomLogsEventParser;
      }
   }
}

