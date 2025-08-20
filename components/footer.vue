<template>

    <div class="footer" id="contact">
			<div class="footer-divider">

			</div>
			<div class="footer-bg">
				<div class="footer-content">
					<img src="/images/sphinks.webp" alt="logo" class="footer-logo">
					<div class="contacts">
						<div class="contact">
							<svg class="svg-icon"> 
								<use xlink:href="#mail-icon"></use>

							</svg>
							
							<span>mysty.vis@gmail.com</span>

						</div>
					</div>
					<div class="socials">
						<a href="https://www.instagram.com/the_pillars_of_wisdom/" target="_blank"  aria-label="Instagram - The Pillars of Wisdom">
							<svg class="svg-icon"> 
								<use xlink:href="#inst-icon"></use>
							</svg>
						</a>
						
						<a href="https://twitter.com/wisdom_cards" target="_blank" aria-label="X - The Pillars of Wisdom">
							<svg class="svg-icon"> 
								<use xlink:href="#x-icon"></use>
							</svg>
						</a>
						
						<a href="https://www.youtube.com/@WisdomPillar" target="_blank" aria-label="Youtube - The Pillars of Wisdom">
							<svg class="svg-icon"> 
								<use xlink:href="#youtube-icon"></use>
							</svg>
						</a>
						
						<a href="https://t.me/pillarsofwisdom" target="_blank" aria-label="Telegram - The Pillars of Wisdom">
							<svg class="svg-icon"> 
								<use xlink:href="#telegram-icon"></use>
							</svg>
						</a>
						
						<a href="https://wa.me/+5219991901325" target="_blank" aria-label="Whatsapp - The Pillars of Wisdom">
							<svg class="svg-icon"> 
								<use xlink:href="#whatsapp-icon"></use>
							</svg>
						</a>
						
						<a href="https://mystyvis.substack.com/" target="_blank" aria-label="Substack - The Pillars of Wisdom">
							<svg class="svg-icon"> 
								<use xlink:href="#substack-icon"></use>
							</svg>
						</a>
					

					</div>
				</div>

			</div>
			
		</div>
</template>


<script setup>


</script>


<style scoped lang="scss">

// @use "includes/variables" as var;
// @use "includes/mixins" as mixin;

.footer {
  margin-top: auto;
}

.footer-divider {
  background-image: url("../images/footer-divider.png");
  background-size: cover;
  background-position: center;
  position: relative;
  overflow: hidden;
  width: 100%;
  height: 2vh;
}

.footer-bg {
  background-image: url("../images/footer-bg.png");
  background-repeat: no-repeat;
  position: relative;

  background-size: cover;
  background-position: center;
  overflow: hidden;
  width: 100%;
  height: auto;
  @media screen and (max-width: 1250px) {
    & {
      background-size: auto 150%;
      background-position: center;
    }
  }
}

.footer-content {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  padding: 30px 0 60px;
  gap: 30px;
  .footer-logo {
    width: clamp(70px, 10vw, 100px);
    height: auto;
  }
  .contacts {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    gap: 20px;

    .contact {
      display: flex;
      justify-content: flex-start;
      align-items: center;
      gap: 10px;
      svg {
        width: 20px;
        height: 20px;
      }
    }
    .call_btn {
      background-color: var(--text_color);
      color: var(--body_bg);
      padding: 5px 10px;
      border-radius: 50px;
    }
  }
  @media screen and (max-width: 768px) {
    & {
      gap: 50px;
    }
  }
}

.socials {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 2vw;
  svg {
    width: 35px;
    height: 35px;
    @media screen and (max-width: 768px) {
      width: clamp(25px, 5vw, 30px);
      height: clamp(25px, 5vw, 30px);
    }
  }

  @media screen and (max-width: 1024px) {
    gap: 5vw;
  }
}


</style>