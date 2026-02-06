package package_139
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class DailyTasksTaskUpdateMessageEventParser implements IMessageParser
   {
      
      private var var_2725:Number;
      
      private var var_2743:int;
      
      private var _status:int;
      
      private var var_3145:int;
      
      public function DailyTasksTaskUpdateMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2725 = 0;
         var_2743 = 0;
         _status = 0;
         var_3145 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2725 = param1.readLong();
         var_2743 = param1.readInteger();
         _status = param1.readByte();
         var_3145 = param1.readInteger();
         return true;
      }
      
      public function get taskId() : Number
      {
         return var_2725;
      }
      
      public function get repeats() : int
      {
         return var_2743;
      }
      
      public function get status() : int
      {
         return _status;
      }
      
      public function get secondsLeft() : int
      {
         return var_3145;
      }
   }
}

