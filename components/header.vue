<template>

      <div class="header">
          <div class="header_inner">
            <!-- <div class="link_block">
              <a href="/#about" class="link-el">About</a>

              <img src="/images/header-star.webp" alt="star" width="59"  height="60" class="star-img"/>
              <a href="/#book" class="link-el">Book</a>


              <img src="/images/header-star.webp" alt="star" width="59"  height="60" class="star-img"/>
              <a href="/#newsletter" class="link-el">Newsletter</a>
            </div> -->
            <!-- <img src="/images/sphinks.webp" alt="logo" class="logo" width="20" height="20"/> -->
			 <span>Acclaimed by Universities Across Europe – Recommended as a Must-Read Resource!</span>
            <!-- <div class="link_block">
              <a href="/#apparel" class="link-el">Apparel</a>
              <img src="/images/header-star.webp" alt="star" width="59"  height="60" class="star-img"/>
              <a href="/#consulting" class="link-el">Consulting</a>
              <img src="/images/header-star.webp" alt="star" width="59"  height="60" class="star-img"/>
              <a href="/#contact" class="link-el">Contact</a>
            </div> -->
          </div>
		  <div class="mobile_header_inner">
			<div class="mobile-header">
				<div class="conntainer">
					<div class="mobile_header_content">
						<!-- <img src="/images/sphinks.webp" alt="logo" class="logo" width="20" height="20"/> -->
			 			<span>Acclaimed by Universities Across Europe – Recommended as a Must-Read Resource!</span>


						<!-- <div class="burger_menu">
							<svg class="icon icon-active" id="burger-btn">
								<use xlink:href="#burger-icon"></use>
							</svg>
							<svg class="icon " id="close-btn">
								<use xlink:href="#close-icon"></use>
							</svg>

						</div> -->
					</div>
				

				</div>
			</div>
			<!-- <div class="mobile_menu">
				<ul>
					<li data-target="/#book">
					<img src="/images/header-star.webp" alt="star" width="59"  height="60" class="star-img" />
					<span>Book</span>
					</li>
					<li data-target="/#about">
					<img src="/images/header-star.webp" alt="star" width="59"  height="60" class="star-img" />
					<span>About</span>
					</li>
					<li data-target="/#newsletter">
					<img src="/images/header-star.webp" alt="star" width="59"  height="60" class="star-img" />
					<span>Newsletter</span>
					</li>
					<li data-target="/#apparel">
					<img src="/images/header-star.webp" alt="star" width="59"  height="60" class="star-img" />
					<span>Apparel</span>
					</li>
					<li data-target="/#consulting">
					<img src="/images/header-star.webp" alt="star" width="59"  height="60" class="star-img" />
					<span>Consulting</span>
					</li>
					<li data-target="/#contact">
					<img src="/images/header-star.webp" alt="star" width="59"  height="60" class="star-img" />
					<span>Contact</span>
					</li>
				</ul>
			</div> -->
		  </div>
      </div>
</template>

<script setup>

</script>



<style scoped lang="scss">


.header {
  position: sticky;
  // position: relative;
  top: 0;
  left: 0;
  width: 100%;
  height: fit-content;
  color: white;
  background-color: #e40000;
//   font-family: "SF-Pro", sans-serif;
  font-weight: 300;
  z-index:15;
}

.header_inner {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: clamp(10px, 4vw, 80px);
  // background: #5a368b;
  // backdrop-filter: blur(7px);
  padding: 8px 0;
  // border-bottom: 1px solid #5a368b;
  color: white;
  font-family: 'Roboto', sans-serif;
  font-weight: 800;
  font-size: clamp(1.3rem, 1.2vw, 1.5rem);
  // @media screen and (max-width: 1024px) {
  //   & {
  //     padding: 10px 0;
  //   }
  // }
  span{
    padding-inline: 2vw;
    text-align: center;
  }
  @media screen and (max-width: 768px) {
    & {
      display: none;
    }
  }
}

.link_block {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 2.5vw;
}

.link-el {
  cursor: pointer;
  border-bottom: 1px solid transparent;
  transition: all 0.3s ease;
  padding-bottom: 10px;
  transform: translateY(5px);
  font-size: clamp(12px, 1.2vw, 14px);
  color: white;
}

.link-el:hover {
  border-bottom: 1px solid;
  border-bottom: 1px solid #f7ac05;
  transition: all 0.3s ease;
}

.star-img {
  width: clamp(10px, 2vw, 20px);
  height: auto;
}

.logo {
  width: clamp(30px, 10vw, 30px);
  height: auto;
}

.mobile_header_inner {
  display: none;
  position: relative;

  @media screen and (max-width: 768px) {
    & {
      display: block;
    }
  }
}

.mobile-header {
  // background: #5a368b;
  background: transparent;
  // border-bottom: 1px solid #5a368b;
  backdrop-filter: blur(8px);
  position: relative;
  z-index: 2;
}

.mobile_header_content {
  display: flex;
  justify-content: center;
  align-items: center;
  padding-block: 10px;
  // background: #5a368b;
  font-family: "Roboto-ExtraBold", sans-serif;
  font-size: clamp(0.9rem, 4vw, 1.3rem);
  span{
    text-align: center;
  }
}

.burger_menu {
  .icon {
    display: none;
    width: clamp(45px, 5vw, 60px);
    height: clamp(45px, 5vw, 60px);
  }
  .icon-active {
    display: block;
  }
}

.mobile_menu {
  width: 100%;
  height: 100vh;
  position: fixed;
  top: -1px;
  left: 0;
  background: rgba(90, 54, 139, 0.9);
  z-index: 100;
  display: none;
  // padding-top: 80px;
  z-index: 1;

  ul {
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
    align-items: flex-start;
    gap: 25px;
    height: 100%;
    padding: 20px 10px;
    li {
      display: flex;
      justify-content: flex-start;
      align-items: center;
      gap: 10px;
      span {
        font-size: clamp(24px, 2vw, 36px);
        font-weight: 400;
      }
    }
  }
}

.mobile-menu-active {
  display: block;
}


</style>