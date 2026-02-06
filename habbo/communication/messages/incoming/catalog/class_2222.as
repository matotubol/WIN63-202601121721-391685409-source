package package_48
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import package_20.RecyclerStatusMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class RecyclerStatusMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public static const const_312:int = 1;
      
      public static const const_1017:int = 2;
      
      public static const const_1124:int = 3;
      
      public function RecyclerStatusMessageEvent(param1:Function)
      {
         super(param1,RecyclerStatusMessageEventParser);
      }
      
      public function getParser() : RecyclerStatusMessageEventParser
      {
         return var_15 as RecyclerStatusMessageEventParser;
      }
   }
}

