package package_188
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import package_189.ObjectIdAndValuePair;
   import package_189.WiredVariable;
   
   public class VariableInfoAndHolders
   {
      
      private var var_1108:WiredVariable;
      
      private var var_3603:Vector.<ObjectIdAndValuePair>;
      
      public function VariableInfoAndHolders(param1:IMessageDataWrapper)
      {
         super();
         var_1108 = new WiredVariable(param1);
         var_3603 = new Vector.<ObjectIdAndValuePair>();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_3603.push(new ObjectIdAndValuePair(param1));
            _loc3_++;
         }
      }
      
      public function get variable() : WiredVariable
      {
         return var_1108;
      }
      
      public function get holders() : Vector.<ObjectIdAndValuePair>
      {
         return var_3603;
      }
   }
}

