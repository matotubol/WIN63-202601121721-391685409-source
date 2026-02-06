package package_95
{
   [SecureSWF(rename="false")]
   public class JsonTextureColumnData
   {
      
      private var var_770:Array = [];
      
      public function JsonTextureColumnData()
      {
         super();
      }
      
      public function addAssetName(param1:String) : void
      {
         var_770.push(param1);
      }
      
      public function get assetNames() : Array
      {
         return var_770;
      }
   }
}

