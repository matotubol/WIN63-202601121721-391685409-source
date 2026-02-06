package package_93
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import package_200.GetCustomFilterResultMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class GetCustomFilterResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function GetCustomFilterResultMessageEvent(param1:Function)
      {
         super(param1,GetCustomFilterResultMessageEventParser);
      }
      
      public function getParser() : GetCustomFilterResultMessageEventParser
      {
         return var_15 as GetCustomFilterResultMessageEventParser;
      }
   }
}

