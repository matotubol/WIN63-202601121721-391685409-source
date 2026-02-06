package package_95
{
   [SecureSWF(rename="false")]
   public class JsonPlaneDrawingData
   {
      
      private var var_176:Number;
      
      private var var_3439:Vector.<JsonPoint> = new Vector.<JsonPoint>();
      
      private var _color:uint;
      
      private var var_324:Array = [];
      
      private var var_4990:Boolean;
      
      private var var_3559:Array = [];
      
      public function JsonPlaneDrawingData()
      {
         super();
      }
      
      public function get z() : Number
      {
         return var_176;
      }
      
      public function set z(param1:Number) : void
      {
         var_176 = param1;
      }
      
      public function get cornerPoints() : Vector.<JsonPoint>
      {
         return var_3439;
      }
      
      public function addCornerPoint(param1:int, param2:int) : void
      {
         var_3439.push(new JsonPoint(param1,param2));
      }
      
      public function get masks() : Array
      {
         return var_324;
      }
      
      public function addMask(param1:JsonMaskDrawingData) : void
      {
         var_324.push(param1);
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function set color(param1:uint) : void
      {
         _color = param1;
      }
      
      public function get bottomAligned() : Boolean
      {
         return var_4990;
      }
      
      public function setBottomAligned(param1:Boolean) : void
      {
         var_4990 = param1;
      }
      
      public function get texCols() : Array
      {
         return var_3559;
      }
      
      public function addTexCol(param1:JsonTextureColumnData) : void
      {
         var_3559.push(param1);
      }
   }
}

