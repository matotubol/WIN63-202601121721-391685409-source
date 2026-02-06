package package_201
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class WiredUserVariablesPage
   {
      
      private var var_3951:String = null;
      
      private var var_3474:int;
      
      private var var_292:int;
      
      private var _amount:int;
      
      private var var_997:Vector.<WiredUserVariablesElement>;
      
      private var var_4450:int;
      
      private var var_4805:int;
      
      public function WiredUserVariablesPage(param1:IMessageDataWrapper)
      {
         super();
         var_3951 = param1.readString();
         var_3474 = param1.readInteger();
         var_292 = param1.readInteger();
         _amount = param1.readInteger();
         var_997 = new Vector.<WiredUserVariablesElement>();
         var _loc2_:int = param1.readInteger();
         var _loc3_:* = 0;
         while(undefined < _loc2_)
         {
            var_997.push(new WiredUserVariablesElement(param1));
            _loc3_ = undefined + 1;
         }
         var_4450 = param1.readInteger();
         var_4805 = param1.readInteger();
      }
      
      public function get variableId() : String
      {
         return var_3951;
      }
      
      public function get totalEntries() : int
      {
         return var_3474;
      }
      
      public function get currentPage() : int
      {
         return var_292;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function get elements() : Vector.<WiredUserVariablesElement>
      {
         return var_997;
      }
      
      public function get userTypeFilter() : int
      {
         return var_4450;
      }
      
      public function get sortTypFilter() : int
      {
         return var_4805;
      }
   }
}

