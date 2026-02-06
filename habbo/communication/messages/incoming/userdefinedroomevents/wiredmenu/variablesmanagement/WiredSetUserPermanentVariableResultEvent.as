package package_89
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import package_201.WiredSetUserPermanentVariableResultEventParser;
   
   [SecureSWF(rename="true")]
   public class WiredSetUserPermanentVariableResultEvent extends MessageEvent implements IMessageEvent
   {
      
      public function WiredSetUserPermanentVariableResultEvent(param1:Function)
      {
         super(param1,WiredSetUserPermanentVariableResultEventParser);
      }
      
      public function getParser() : WiredSetUserPermanentVariableResultEventParser
      {
         return this.var_15 as WiredSetUserPermanentVariableResultEventParser;
      }
   }
}

