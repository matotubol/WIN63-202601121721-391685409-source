package com.sulake.habbo.avatar.wardrobe
{
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   
   public class NftOutfit extends Outfit
   {
      
      public static const const_462:String = "habbo:avatar";
      
      public static const const_887:String = "habbo:clothes";
      
      public static const collectionGenesis:String = "habbo:avatar_genesis";
      
      private var var_197:String;
      
      private var var_3993:String;
      
      private var _contractKey:String;
      
      public function NftOutfit(param1:HabboAvatarEditor, param2:String, param3:String, param4:String, param5:String, param6:String)
      {
         super(param1,param3,param4);
         this.var_197 = param2;
         this.var_3993 = param5;
         this._contractKey = param6;
         initNftColors();
      }
      
      public function get id() : String
      {
         return var_197;
      }
      
      public function get tokenId() : String
      {
         return var_3993;
      }
      
      public function get contractKey() : String
      {
         return _contractKey;
      }
      
      private function initNftColors() : void
      {
         switch(_contractKey)
         {
            case "habbo:avatar":
               super.view.setColors(4294928384,4294936611,-1,-1);
               break;
            case "habbo:clothes":
               super.view.setColors(4288715443,4289965509,-1,-1);
               break;
            case "habbo:avatar_genesis":
               super.view.setColors(4280129447,4282165689,4287901875,4289219523);
               break;
            default:
               super.view.setColors(4294967295,4294967295,-1,-1);
         }
      }
   }
}

