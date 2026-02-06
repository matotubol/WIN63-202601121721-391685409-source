package package_47
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class RecycleItemsMessageComposer implements IMessageComposer
   {
      
      private var var_1863:Array;
      
      public function RecycleItemsMessageComposer(param1:Array)
      {
         super();
         var_1863 = [];
         var_1863.push(param1.length);
         var_1863 = var_1863.concat(param1);
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return var_1863;
      }
   }
}

