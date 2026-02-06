package package_48
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class PrizeMessageSubProduct
   {
      
      private var var_2839:String;
      
      private var var_3730:int;
      
      public function PrizeMessageSubProduct(param1:IMessageDataWrapper)
      {
         super();
         var_2839 = param1.readString();
         var_3730 = param1.readInteger();
      }
      
      public function get productItemType() : String
      {
         return var_2839;
      }
      
      public function get productItemTypeId() : int
      {
         return var_3730;
      }
   }
}

