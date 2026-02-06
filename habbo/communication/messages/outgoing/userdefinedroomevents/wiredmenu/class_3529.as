package package_192
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class WiredGetRoomLogsComposer implements IMessageComposer, class_13
   {
      
      private var var_120:Array = [];
      
      public function WiredGetRoomLogsComposer(param1:int, param2:int, param3:int, param4:int, param5:String)
      {
         super();
         var_120.push(param1);
         var_120.push(param2);
         var_120.push(param3);
         var_120.push(param4);
         var_120.push(param5);
      }
      
      public function getMessageArray() : Array
      {
         return this.var_120;
      }
      
      public function dispose() : void
      {
         this.var_120 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

