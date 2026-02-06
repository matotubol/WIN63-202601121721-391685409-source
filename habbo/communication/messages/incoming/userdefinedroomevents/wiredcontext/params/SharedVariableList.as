package package_188
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import package_189.SharedVariable;
   
   public class SharedVariableList extends class_3414
   {
      
      private var var_3542:Array = [];
      
      private var var_2452:Array = [];
      
      public function SharedVariableList(param1:IMessageDataWrapper)
      {
         super();
         var _loc2_:int = param1.readInteger();
         var _loc4_:int = 0;
         while(0 < _loc2_)
         {
            var _loc3_:SharedVariable = new SharedVariable(param1);
            var_3542.push(null);
            var_2452.push(null.wiredVariable);
            _loc4_++;
         }
      }
      
      override public function get variables() : Array
      {
         return var_2452;
      }
      
      public function get sharedVariables() : Array
      {
         return var_3542;
      }
   }
}

