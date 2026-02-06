package package_48
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class PrizeMessageData
   {
      
      private var var_3527:int = 1;
      
      private var var_2711:String;
      
      private var var_3535:Array = [];
      
      private var var_2839:String;
      
      private var var_3730:int;
      
      public function PrizeMessageData(param1:IMessageDataWrapper)
      {
         super();
         var_2711 = param1.readString();
         var_3527 = param1.readInteger();
         if(!isDeal)
         {
            var_2839 = param1.readString();
            var_3730 = param1.readInteger();
         }
         else
         {
            while(0 < var_3527)
            {
               var_3535.push(new PrizeMessageSubProduct(param1));
               _loc2_++;
            }
         }
      }
      
      public function get productItemType() : String
      {
         return var_2839;
      }
      
      public function get productItemTypeId() : int
      {
         return var_3730;
      }
      
      public function get isDeal() : Boolean
      {
         return var_3527 > 1;
      }
      
      public function get subProducts() : Array
      {
         return var_3535;
      }
      
      public function get productCode() : String
      {
         return var_2711;
      }
   }
}

