package package_89
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import package_201.WiredUserVariablesListEventParser;
   
   [SecureSWF(rename="true")]
   public class WiredUserVariablesListEvent extends MessageEvent implements IMessageEvent
   {
      
      public function WiredUserVariablesListEvent(param1:Function)
      {
         super(param1,WiredUserVariablesListEventParser);
      }
      
      public function getParser() : WiredUserVariablesListEventParser
      {
         return this.var_15 as WiredUserVariablesListEventParser;
      }
   }
}

