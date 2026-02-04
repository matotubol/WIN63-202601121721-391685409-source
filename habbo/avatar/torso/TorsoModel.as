package com.sulake.habbo.avatar.torso
{
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.common.CategoryBaseModel;
   import com.sulake.habbo.avatar.common.class_2582;
   
   public class TorsoModel extends CategoryBaseModel implements class_2582
   {
      
      public function TorsoModel(param1:HabboAvatarEditor)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         super.init();
         initCategory("cc");
         initCategory("ch");
         initCategory("ca");
         initCategory("cp");
         var_265 = true;
         if(!var_18)
         {
            var_18 = new TorsoView(this);
            if(var_18)
            {
               var_18.init();
            }
         }
      }
   }
}

