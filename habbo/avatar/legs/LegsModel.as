package com.sulake.habbo.avatar.legs
{
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.common.CategoryBaseModel;
   import com.sulake.habbo.avatar.common.class_2582;
   
   public class LegsModel extends CategoryBaseModel implements class_2582
   {
      
      public function LegsModel(param1:HabboAvatarEditor)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         super.init();
         initCategory("lg");
         initCategory("sh");
         initCategory("wa");
         var_265 = true;
         if(!var_18)
         {
            var_18 = new LegsView(this);
            if(var_18)
            {
               var_18.init();
            }
         }
      }
   }
}

