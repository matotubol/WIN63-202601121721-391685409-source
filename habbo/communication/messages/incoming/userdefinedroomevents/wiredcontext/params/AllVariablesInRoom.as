package package_188
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import package_189.WiredVariable;
   
   public class AllVariablesInRoom extends class_3414
   {
      
      private var var_3003:int;
      
      private var var_2452:Array = null;
      
      public function AllVariablesInRoom(param1:IMessageDataWrapper)
      {
         super();
         var_3003 = param1.readInteger();
      }
      
      override public function get variables() : Array
      {
         return var_2452;
      }
      
      public function get needsSynchronize() : Boolean
      {
         return var_2452 == null;
      }
      
      public function get hash() : int
      {
         return var_3003;
      }
      
      public function synchronize(param1:Vector.<WiredVariable>) : void
      {
         var_2452 = [];
         for each(var _loc2_ in param1)
         {
            var_2452.push(_loc2_);
         }
      }
   }
}

