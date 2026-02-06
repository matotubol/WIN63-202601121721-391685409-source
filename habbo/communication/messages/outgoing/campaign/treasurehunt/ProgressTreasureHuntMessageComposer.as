package package_99
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class ProgressTreasureHuntMessageComposer implements IMessageComposer
   {
      
      private var var_2821:String;
      
      private var var_4222:String;
      
      public function ProgressTreasureHuntMessageComposer(param1:String, param2:String)
      {
         super();
         var_2821 = param1;
         var_4222 = param2;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_2821,var_4222];
      }
   }
}

