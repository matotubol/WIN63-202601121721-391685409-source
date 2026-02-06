package package_156
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class AddNftToTradeComposer implements IMessageComposer
   {
      
      private var var_120:Array = [];
      
      public function AddNftToTradeComposer(param1:Vector.<int>)
      {
         super();
         var_120.push(param1.length);
         for each(var _loc2_ in param1)
         {
            var_120.push(_loc2_);
         }
      }
      
      public function getMessageArray() : Array
      {
         return var_120;
      }
      
      public function dispose() : void
      {
      }
   }
}

