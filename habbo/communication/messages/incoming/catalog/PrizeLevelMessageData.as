package package_48
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class PrizeLevelMessageData
   {
      
      private var var_3115:int;
      
      private var var_4048:int;
      
      private var var_1475:Array;
      
      public function PrizeLevelMessageData(param1:IMessageDataWrapper)
      {
         super();
         var_3115 = param1.readInteger();
         var_4048 = param1.readInteger();
         var_1475 = [];
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_1475.push(new PrizeMessageData(param1));
            _loc3_++;
         }
         var_1475.sortOn("productCode",1);
      }
      
      public function get prizeLevelId() : int
      {
         return var_3115;
      }
      
      public function get probabilityDenominator() : int
      {
         return var_4048;
      }
      
      public function get prizes() : Array
      {
         return var_1475;
      }
   }
}

