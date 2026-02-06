package package_171
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import package_139.DailyTasksActiveListMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class DailyTasksActiveListMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function DailyTasksActiveListMessageEvent(param1:Function)
      {
         super(param1,DailyTasksActiveListMessageEventParser);
      }
      
      public function getParser() : DailyTasksActiveListMessageEventParser
      {
         return var_15 as DailyTasksActiveListMessageEventParser;
      }
   }
}

