package package_25
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3644
   {
      
      private var var_3861:String;
      
      private var var_5163:Vector.<class_2073> = new Vector.<class_2073>(0);
      
      public function class_3644(param1:IMessageDataWrapper)
      {
         super();
         var_3861 = param1.readString();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            quickLinks.push(new class_2073(param1));
            _loc3_++;
         }
      }
      
      public function get searchCode() : String
      {
         return var_3861;
      }
      
      public function get quickLinks() : Vector.<class_2073>
      {
         return var_5163;
      }
   }
}

