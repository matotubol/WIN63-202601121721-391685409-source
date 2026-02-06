package package_171
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import package_139.DailyTasksTaskUpdateMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class DailyTasksTaskUpdateMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function DailyTasksTaskUpdateMessageEvent(param1:Function)
      {
         super(param1,DailyTasksTaskUpdateMessageEventParser);
      }
      
      public function getParser() : DailyTasksTaskUpdateMessageEventParser
      {
         return var_15 as DailyTasksTaskUpdateMessageEventParser;
      }
   }
}

