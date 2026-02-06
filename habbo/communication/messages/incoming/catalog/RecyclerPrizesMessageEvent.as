package package_48
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import package_20.RecyclerPrizesMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class RecyclerPrizesMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function RecyclerPrizesMessageEvent(param1:Function)
      {
         super(param1,RecyclerPrizesMessageEventParser);
      }
      
      public function getParser() : RecyclerPrizesMessageEventParser
      {
         return var_15 as RecyclerPrizesMessageEventParser;
      }
   }
}

