package package_201
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import flash.utils.Dictionary;
   
   public class WiredUserPermanentVariablesList
   {
      
      private var var_3566:int;
      
      private var var_4152:int;
      
      private var var_4074:String;
      
      private var var_4477:String;
      
      private var var_1820:int;
      
      private var _ownerName:String;
      
      private var var_4720:String;
      
      private var var_3411:Vector.<WiredVariableStorageParameter>;
      
      private var var_2226:Dictionary;
      
      public function WiredUserPermanentVariablesList(param1:IMessageDataWrapper)
      {
         super();
         var_3566 = param1.readInteger();
         var_4152 = param1.readInteger();
         var_4074 = param1.readString();
         var_4477 = param1.readString();
         if(var_3566 != 1)
         {
            var_1820 = param1.readInteger();
            _ownerName = param1.readString();
            var_4720 = param1.readString();
         }
         var_3411 = new Vector.<WiredVariableStorageParameter>();
         var_2226 = new Dictionary();
         var _loc2_:int = param1.readInteger();
         var _loc3_:* = 0;
         while(undefined < _loc2_)
         {
            var _loc4_:WiredVariableStorageParameter = new WiredVariableStorageParameter(param1,true);
            var_3411.push(null);
            var_2226[null.variableId] = true;
            _loc3_ = undefined + 1;
         }
      }
      
      public function get entityType() : int
      {
         return var_3566;
      }
      
      public function get entityId() : int
      {
         return var_4152;
      }
      
      public function get entityName() : String
      {
         return var_4074;
      }
      
      public function get entityFigure() : String
      {
         return var_4477;
      }
      
      public function get ownerId() : int
      {
         return var_1820;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function get ownerFigure() : String
      {
         return var_4720;
      }
      
      public function get variableStorage() : Vector.<WiredVariableStorageParameter>
      {
         return var_3411;
      }
      
      public function get variableIds() : Dictionary
      {
         return var_2226;
      }
   }
}

