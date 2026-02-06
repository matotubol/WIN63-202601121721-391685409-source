package package_156
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class RemoveNftFromTradeComposer implements IMessageComposer
   {
      
      private var var_4911:int;
      
      public function RemoveNftFromTradeComposer(param1:int)
      {
         super();
         var_4911 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_4911];
      }
   }
}

