package package_48
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import package_20.RecyclerFinishedMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class RecyclerFinishedMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public static const const_1193:int = 1;
      
      public static const const_1110:int = 2;
      
      public function RecyclerFinishedMessageEvent(param1:Function)
      {
         super(param1,RecyclerFinishedMessageEventParser);
      }
      
      public function getParser() : RecyclerFinishedMessageEventParser
      {
         return var_15 as RecyclerFinishedMessageEventParser;
      }
   }
}

