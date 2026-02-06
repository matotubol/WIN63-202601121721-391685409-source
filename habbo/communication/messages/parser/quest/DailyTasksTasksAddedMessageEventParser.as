package package_139
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class DailyTasksTasksAddedMessageEventParser implements IMessageParser
   {
      
      private var var_1705:Vector.<class_3417>;
      
      public function DailyTasksTasksAddedMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_1705 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1705 = new Vector.<class_3417>();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_1705.push(new class_3417(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get tasks() : Vector.<class_3417>
      {
         return var_1705;
      }
   }
}

