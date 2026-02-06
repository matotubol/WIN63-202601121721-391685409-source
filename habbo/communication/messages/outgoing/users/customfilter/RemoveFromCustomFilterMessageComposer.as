package package_126
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class RemoveFromCustomFilterMessageComposer implements IMessageComposer
   {
      
      private var var_120:Array = [];
      
      public function RemoveFromCustomFilterMessageComposer(param1:String)
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

