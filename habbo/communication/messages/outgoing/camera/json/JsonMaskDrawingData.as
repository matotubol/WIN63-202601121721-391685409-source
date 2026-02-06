package package_95
{
   [SecureSWF(rename="false")]
   public class JsonMaskDrawingData
   {
      
      private var _name:String;
      
      private var var_559:JsonPoint;
      
      private var _flipH:Boolean;
      
      private var _flipV:Boolean;
      
      public function JsonMaskDrawingData(param1:String, param2:JsonPoint, param3:Boolean, param4:Boolean)
      {
         super();
         this._name = param1;
         this.var_559 = param2;
         this._flipH = param3;
         this._flipV = param4;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get location() : JsonPoint
      {
         return var_559;
      }
      
      public function get flipH() : Boolean
      {
         return _flipH;
      }
      
      public function get flipV() : Boolean
      {
         return _flipV;
      }
   }
}

