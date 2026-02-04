package com.sulake.habbo.avatar.head
{
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.common.CategoryBaseModel;
   import com.sulake.habbo.avatar.common.class_2582;
   
   public class HeadModel extends CategoryBaseModel implements class_2582
   {
      
      public function HeadModel(param1:HabboAvatarEditor)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         super.init();
         initCategory("hr");
         initCategory("ha");
         initCategory("he");
         initCategory("ea");
         initCategory("fa");
         var_265 = true;
         if(!var_18)
         {
            var_18 = new HeadView(this);
            if(var_18)
            {
               var_18.init();
            }
         }
      }
   }
}

