package package_38
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class TreeGameObjectData extends SnowWarGameObjectData
   {
      
      public static const const_31:int = 9;
      
      public function TreeGameObjectData(param1:int, param2:int)
      {
         super(param1,param2);
      }
      
      override public function parse(param1:IMessageDataWrapper) : void
      {
         parseVariables(param1,9);
      }
      
      public function get locationX3D() : int
      {
         return getVariable(2);
      }
      
      public function get locationY3D() : int
      {
         return getVariable(3);
      }
      
      public function get direction() : int
      {
         return getVariable(4);
      }
      
      public function get height() : int
      {
         return getVariable(5);
      }
      
      public function get fuseObjectId() : int
      {
         return getVariable(6);
      }
      
      public function get maxHits() : int
      {
         return getVariable(7);
      }
      
      public function get hits() : int
      {
         return getVariable(8);
      }
   }
}

