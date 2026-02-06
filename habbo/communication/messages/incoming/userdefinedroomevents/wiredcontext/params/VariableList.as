package package_188
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import package_189.WiredVariable;
   
   public class VariableList extends class_3414
   {
      
      private var var_2452:Array = [];
      
      public function VariableList(param1:Array)
      {
         super();
         var_2452 = param1;
      }
      
      public static function createFromMessage(param1:IMessageDataWrapper) : VariableList
      {
         var _loc5_:int = 0;
         var _loc4_:WiredVariable = null;
         var _loc2_:Array = [];
         var _loc3_:int = param1.readInteger();
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = new WiredVariable(param1);
            _loc2_.push(_loc4_);
            _loc5_++;
         }
         return new VariableList(_loc2_);
      }
      
      override public function get variables() : Array
      {
         return var_2452;
      }
   }
}

