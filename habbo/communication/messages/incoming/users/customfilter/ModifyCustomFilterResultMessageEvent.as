package package_93
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import package_200.ModifyCustomFilterResultMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class ModifyCustomFilterResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public static const const_662:int = 0;
      
      public static const const_424:int = 1;
      
      public static const const_670:int = 3;
      
      public function ModifyCustomFilterResultMessageEvent(param1:Function)
      {
         super(param1,ModifyCustomFilterResultMessageEventParser);
      }
      
      public function getParser() : ModifyCustomFilterResultMessageEventParser
      {
         return var_15 as ModifyCustomFilterResultMessageEventParser;
      }
   }
}

