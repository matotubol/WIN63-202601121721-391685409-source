package package_89
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import package_201.WiredUserPermanentVariablesEventParser;
   
   [SecureSWF(rename="true")]
   public class WiredUserPermanentVariablesEvent extends MessageEvent implements IMessageEvent
   {
      
      public function WiredUserPermanentVariablesEvent(param1:Function)
      {
         super(param1,WiredUserPermanentVariablesEventParser);
      }
      
      public function getParser() : WiredUserPermanentVariablesEventParser
      {
         return this.var_15 as WiredUserPermanentVariablesEventParser;
      }
   }
}

