package package_78
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class ClaimDailyTaskComposer implements IMessageComposer
   {
      
      private var var_120:Array = [];
      
      public function ClaimDailyTaskComposer(param1:int)
      {
         super();
         var_120.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return var_120;
      }
      
      public function dispose() : void
      {
         var_120 = [];
      }
   }
}

