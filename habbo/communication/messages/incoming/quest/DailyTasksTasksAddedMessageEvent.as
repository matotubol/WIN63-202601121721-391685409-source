package package_171
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import package_139.DailyTasksTasksAddedMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class DailyTasksTasksAddedMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function DailyTasksTasksAddedMessageEvent(param1:Function)
      {
         super(param1,DailyTasksTasksAddedMessageEventParser);
      }
      
      public function getParser() : DailyTasksTasksAddedMessageEventParser
      {
         return var_15 as DailyTasksTasksAddedMessageEventParser;
      }
   }
}

