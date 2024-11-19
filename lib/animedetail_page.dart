import 'dart:ui';

import 'package:animeapp/typography.dart';
import 'package:flutter/material.dart';

import 'color.dart';

class AnimeDetailPage extends StatelessWidget {
  final String title;
  final String imageUrl;

  AnimeDetailPage({
    Key? key,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  final List<Map<String, String>> trendingAnime = [
    {
      'title': 'Frieren: Beyond',
      'imageUrl': 'https://placeholder.com/180x250',
      'rating': '9.22'
    },
    {
      'title': 'One Piece Fan Letter',
      'imageUrl': 'https://placeholder.com/180x250',
      'rating': '8.5'
    },
    {
      'title': 'Fullmetal AI',
      'imageUrl': 'https://placeholder.com/180x250',
      'rating': '8.8'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Anime Detail', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background image with dark overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Stack(
              children: [
                Image.network(
                  'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAJQAvwMBEQACEQEDEQH/xAAbAAACAwEBAQAAAAAAAAAAAAAAAQMEBQYCB//EADsQAAIBAwIDBgQDBwQCAwAAAAECAwAEEQUhEjFBBhMiUWFxFIGRoTJCsSMzUmLB0fAVJOHxNEMHU3L/xAAbAQABBQEBAAAAAAAAAAAAAAAAAQIDBAUGB//EADURAAIBAwIEAwYFBQEBAQAAAAABAgMEEQUhEjFBURMiYQZxgZGh8BQyQrHRFSMzweHxgiT/2gAMAwEAAhEDEQA/AMWupMYKACgApACgBUAFACoAVACoAKACgBUAKgAoAVACoADQAqAPJoAVABQAqACgUuUogUAOgApAFQAUAKgD2sTupZFJVeZqtUu6FOpGlOWJS5IljRnKLklsiOrJEKgApMgI0AFACoAVABSgKgBGgBZoAWaBRGgQVACoFCgC7SiBQAUgBQAUALNHIAIOcMMHyIwaapKW65C4a5nUaFbI9nA/CMjJ9/OvMPaCvL+oVN+WF8kjpLKKVvEzu0ejtptwJI/FbTbof4T1U11/s/rC1ChwT/yR5+q7/wA+pkXtt4M8rkzLktpY4UmdCEk/Dny8/wBa16d7RqV5UYyzKPP79OpWdGcYKbWzHZW5uZ+HHhUFmPkKh1O+VnbOp15L1Y+2outUUDxcxCGYqOWAR6U7Trp3VtGrLmxLikqVRxRNp1uJ5ZONSY0jYk+RxgfeoNXvXaW3HF+bKx89/oSWlHxamHyK0yGOVkP5TjfrV+hWjWpxqR5NEFSHDJpnipiMVAoqAA0ALFACoARpQFQAqACgC5SiBSAFABQBNZpBJcBLqYxRttxgZCn19Kq3dStTpOdGPE107+717ElKMJSxN4LGq6VcaXKBPwtG34JEPhYf0qrpurW+owbpbNc4vmvv/wBJa9tOi/N8zQihTWNNEh2uofCx/i25n7Vzta7nomoOHOlPfHbPPHuZfp0leUM8pI0ezyPEscMwwy5GK5rW6kK13OrTeVLc0baLjRjF9Db1K1j1HSGt5ehDA+RB/wA+tUdNvalhcqtD1Xwf2mLWpKrHhZzNxJHc3JglH7FkwAOYArRtrmtQqqvB+bOfnz+YSpQnDw3yPNrYnTra4DlWeQ7OvVRyq7rGqrUZw4Nkly9XzILS1dBPPNmZcWM1zdQ90vhmPAGxsCOefkQa39I1KjQ0+XiPDh09/b9ijeW0511jqb93ZxadZLZ22dxmRsbsfWuPuNSrX9w61X4LokatG3hRhwxKsthBe2byTgRzHaJlHkOvnWhp+sVrOpGCeYZ3Xv7EFzaQqJ9zlm2Jr0pNNZRzzWGABJwNzQ3gQkktbiNO8kgkVD+ZkIFV4XlvUn4cKicuye5JKjOK4nF4ITVkjEaAEaAPNABSgKgBUAW6UQdIAUAFIBNaW7XVwkKPGjNyLnA+uDVW9u4WdF1pptLt69eaJaNF1ZcKOr09Jmtn0TV4sMF/YsTkMB0B9K4LUalNVI6rpsuvmXZvuvXr0z7zat4vhdvXXu+/Qy+zqyJLMijiIkAxn8XMY+dW/aupGo6Mu6f1wxNMg48afRml33dXQki4uFcYD+XlXKcPFHDNbh2N61uEljLIds8RB6Z5iqU4uMsMa0cvqNo9pdzMnJWEie3lWnSqKcENweri5V1RE5YyPY8h8qPDw8kjWxb0SJo0dmP7Pj4gvrjFQ3E09hiiF3MhlaSQkjiAFNpxeNh6R6YG8iiFoAOBm4ixxw8t6cpKm3xDJROd1vSGskS6hbvLaU8IfqD1z8wcV6Ro2s0r7+zjE109O/7HPXdrKk+LoyxolrHGqTSJ+0YZXO2B/m9YftDqNStV/DUnsueOr+9sdy9YW0Yw8WS3f0Rn6zqBvLlu7djCuy56+uK3tE0pWNHM153z9PTJQvbrxpYjyRnVuFERpQFQAqAFQAUoCoAt0ogUgDOBzOKAOg7PW+laght54f8AdAZBLnDe2+1cdr9fVbGf4ilU/tvphbfTqatnC2qrgktw1XRG0uZbuFGltlPiXi3T/im6drUNWoSs6zUajXPGz93r9oWra/hpqrDdI2rOeK9htZZtxG48XFgqem/ruPlXITVazq1KUXjOU13++aNVKFSKl8Ue7PTo4Gupo5AVlkDAY3RsncHyNPvtQlc06VOccSprGe62+qClR4Jykv1EGqQkN8QMcMu+3Q9RVSjLPlLkSLS7nu5u7J8DjBpasMrINFu9ZZoG4gC67fL/ADFR08pjVHc5WOTxEH8jYPtWo4+UU3xcqqBVOMDJqg4NsEjJvbriaNAf5qtU6eBS3ps7LbSKGIEp39hUVWCckNZ47mbUVWGRitrF4pN8DhBz9au2N3GxreL+rDS97WxUrUvFjwlfWpWjs1lUcAuGIQeSDn/QfWtb2boRr3cpz3cd/i+v36divqNR06UYR67HPb+Vd6YDFSiCNGQFRkBUogqACgBUoFugQsWNlPf3K29rHxyNyGcVVvbyjZUnVrywiSlTlVeInddnOz9xpy4v7LT5snJk3Zx6brj715xreu0L2WbapUi+2yj9JJr5M2ba2dNYmkbrafprsshsrcOpyriIAr7Ecq5l395wun4ssPmuJtfUuKnFPKW4XECFeHAKEYOdwfeo6c5ZyuZKlk5dreKzuprSEBYieEeQJ3X77VrVa1Sv/dqPMvtMWMUlhFyxQSWDpEQrgnCnnk9PtUFacqlXilvtz9w6KUShNdBoJIJNnB408sjmKkjDEsosJGQJh3yMp2J+lWeDYcy937XGe7zlhvt1FQ8GHuMbSM19PYSNJLNFErnGGNXYPKwkR8RCdRtkXJlJUKVYheoIH9ak/CSyHiIovLHLIvBKMMVVSfUkf0+m9Sqi0hviJmzp8bXE628JGMZznpkjP1BqlWThFyaH5TNm7iEdv8NGMIcZ/wCfUmqUHmXELGJIthYak6W12XEVsgK8Bxvyqxa6lcafKVSjjMttyvc28aqSkV9Q0LSEtHFpbuzDZZGffPTer1D2j1F14zqT8vVY2wVXYUeHEYmLH2VvTEJJpreHIzwMxLfpXTVPa6yjLhhGUl32X7sz1ptXG7SIoOzlxL+ORfQICc/pTa3tZbx/xwb9+38j46ZP9UsEOr6I2mRq01wnG3KE44seex/tV/StaeoTxGk0l+rO3u/8yV7i0VFZ4s+nUyK3ilgVKIFACoAtUoh6R2jcPG7I67hlOCKbKEZxcZLKYqbTyuZtW3arV4Aoa6MgXlxgE/XFc1e+yun3GZQjwP05fIvUb+pDaW6Naz7bybrdwcW2zDGx9utc7c+xleKzSkpenX7+JfhqNKTxJNGzFeW+pJGzyFeIZXxYU/PofQ/WuYqW86EnDGGuaNCMsrK5Hm/0hpmLQy4dVwVkG5HQ5pKVfgypIemYvxD2808N2pUyAcR6hujfXrV2KylKH2h+EzG1HVu94u/T9quzcP5vX0P61bo2+NlyH5wR6fayyObmUMIicRoebdN/nUs+GK4UQzqt8i/LcT5Q274j/h2Ax7eew60yMY9VuRqWTF1SeS4h/wBm7N8KO8dXyeM5655+f9qu0VwPMlzHS35GR8He94XksigYoC/ecSgnYDB9cE1bU6b2yQvPRE9vpN+4MltLaSAgERtHwE5Gcg52OD9xTHUpLZ5943MkQQz3tjexz9zJAoB5PlDgHr13G+adKEJwcW8/v94HqZ0Vp2hmkRFuY5l8IIkKZDEjfJ8hy9d6zqlgv0FmFbozoLC5+HiZ8s0kuDheRHTesqrTy8dCWW5biaWUiSVzDGf/AGHn8vKoXhbJZGNHq6eNwIbSMxoSA8r7u/8A3RFNLMuf0GqLW5Q1q/m0qPu7WCT4grnvCpKxj9C36VvaJpVK+l4txJcK6ZWX/C/cz7u5lTWILfucs9nqF03fyRTOX3MknNvmeddz+OsLWPhqcYpdO3yMjwa1V54WR3GnXlunHLbyBP4uHIp9DVLOvLhp1E2JO2qwWZRKfMZrQK7CgQVKBa5c6UaTm0nXg4oyOM4UdayK+t2VKTjxZa7FuFlWms4wXbfQr6bcCKNRzLygfaqFT2qsYLKUn8P+ky06r3X1Lun6FYuwW71LcnZYgM5+exrJufay4f8Aho4Xq8/Qsw0yK/NL5HR2mhWNtG62d7P4h+GRcrn6bVy99q1a8qKdeKz3SwaFCiqSxELa6khzbXbHEeyyDnH/AHBqpKKluixjqLVrNL+LupMR3AHgYbhvUeftRRm6UsrdDkuxxx0t4tXYXA4lVeNAVJ4vXPStynXjKl5SOWSeSdQVjZTxE54QA3z9/wClHCyHBF8XFbxyLNCXcrxLGvhxtkDB5U/w3JrAnIjHFLGG7oRONyAvGw9T/maXZPHMVSZRjW5jlZ8FogSzKc4Gckemd6mfA0l1E42j3HeT8UavGACoDYGxLLuOXPl9PnSSprfDHKafMI79JIe9Vl24WMYOVBD8R28+tLwTjLH3ywO8rK5SJvC8sUhdQFbOCWH83y+3zp6nLHIXB02gX7RhUvYWkKeHxYbJHU+3lj51nXdBS3i9+ZKpNrBsBJb64+Ill4UxhM4GB6DpWZJqHlxuPysEqzLFJ3VjC09z/EV2T2z+tN4XjMnhBw53ZLdm4aIDVtR4Vx+5jGSfekgoZzBfEZiPRFWCaEDiiUxxjbvHI4vryH3p04N89wZqqLeS245oS8eN3ckD6nGfpUKUlLyvf0I3ufO+0sdrFqsi2aFFwCVzkZO+1eo+z1avVsVKvLPPHuXfv7zAvoQhVxBGVW8iiKlAtxuY3V15qQR702rTjVg4S5PYIycXlGi+szySLJIgd15F5HYDz2JxXPL2Xso8m8fD98F7+o1eyL1nr1sV4NSsgw6PCQCPk2f1rOufZF5zbVfhL+Vj9ienqb/WiWTU9KjcvYzXEbnmskH9Vb+lUn7M3+MPhfx/lEy1Cl1yTWfaFYpFL34UdR8OSPptVWr7NXuPyJ//AEiWN/Q7mzDrGiatcpF8chnxtG37P6c/1rFr6dd2i80H8N/2LcK8JflZptpSGAxq5Veah/EAfQjcVn+P3JVPqcx2psr22hWRgZI878PiUev8u1atlVhPyhJqW6OTnun8IibuXOS54lwB1JAG3nzrWjTW6e5CyGH9lM0pcqjts7Stgt0zjofQHcnfapJbxx2IwmkMreG6Cy8WOIN48nmoHkd9zilikv07fe4hG2oraRxl5pIu7P7oy5PT8WMYPTelVLj6ZEzg9RXLzr3qzQSIBwuwAUr9BuMnOBzxzpODheGhMiLWEn/k2kWc8PCmM7nzHXkScbcvWlxUivLIXYLI2KvIrSQuwPM7kDnufkd8DnRU8RpPGwLmbVssL8L21zmFlwU4sYx+ZT0P96pycksSRKpM3LNoo0CO5jxkF1OPlnG3/FUK8W+SJactxz3bDw8YghXcRqeDiPmSdz9KiVPusv7++ZY2ZBI8SjieNpcnIOCAfmdz8sU5Rb2yIEVyYJBK1oe9P4GkQkKPQUOnxLGdvvqRmnBqMQlV5uO8uRusYceD2Wo52tXgcnFqHfDx8xjcU8Jmbq0NnrqvcxwyQzAfvjgKfQnNbWl397p01RxxRz+XDz8Nijc0KVVNt4ZxNelnPvZhSgWKUaFABmkwAZoFJYLZ7gS92V8C8TAsBkenmao3t3QtlF13hN4J6NKpUzwdCzpuj3d/IYrWADAyxOAAPOqNfXbG2h5ZZ9xPCxrzfm2950en2N/p7qJNWliiHMRcLA+xOf0riNV1G0vd6Vuk+75/Q2ra3qU/zSydJFxXlu5gn+IA8LRycIJHyrChTcXlLBZn5Xho+fdouxssDSz6csoBOTbSAA/JuvsfrW9a6iniFXb1GuGeRx7TSRkwBGjIyrISQSfX/P0rWwn5uZE0RNKcYGFwuNuvufOlxka0RyzcWAyF0UYIBwPY49vvT4prkRtHl5Fkc8fCsX8oxwY/hHnzpVt7xuD0krREeIsgweLJ4vb9aR4e75hgurLFNxSXPB30ihSyjgOOWcjb7VG04rbkLgv2t+sUhkLjIHgKjPkNzny9PpUE4NrA9G3o11EzLwOCzEKkUrAjzGw9yM7VTuYeXD+ZLA011Tu9m0qO2l/mWRce1UfAXSeV8C0op9Tys887H/cxpk8kUg/akahDkgcDzdW11NGe5eTj/iGTmr+nXdvRqrxoKUfqircwnOGISwynYdmdau5OOK1eIg/vJTwfMda7Cv7QaXThjxFJdlv80YStK7e6LUvYfVVUuGtHYcwJt6r0/avT5PhXEvht9B0rGqlkwL6zubGcw3kLRSDo2+fXI2Nb9tdUbqn4lGWUU6lOVN4ksFarBGWaUQKACgApBSa1maCQsrEA7HBxWNrdi7uhmK80d1/Bcsa6pVN+TNiwvO4fjABXG4rz6cG+Z0S3Wxup8Lex97Dcqs3/ANc3I+x/uaptOHQkjJos29teW6G4Z/h4lHikDBRj3zUXEpPEd2PdSEtmeodaE0pjMck9u2zSNt/3RKg8ZzgPB7HPal2M0vVLuaa11KSDjXIhkTIB/wD15VoUNSqUoKM4kc4TXNHAa/pj6LcLbtMs7cPjMa7A+VbltXVxHiSwQzi48zJ7zfxAsDjarWCFsWR1OTn5ClEPSsfzHJx1pAJlOPINjfpTByRMkoEmzYPnnemuLwOSOh7NwzXdzFckd9ADmQqN/nis+8nGEXFbMnpxzufT9NjsHThgAVT+TiI+1czVqVYvLJpRZal0mNwWt7iWB/NYo2/Vc/ekp3iT/uRUl23X7Mry4sbMyL2y7Swf+HqkTp/AQI81vWt5otRcNWi4vum3/H7FWcLjOYyz8Dwmv38Lx2uu6QN9hLnwn58vvRcaPaVIOrYV+Jr9L/N8OTfyEhWqKWKkcevQ53takjFJkuDJas+BbsoUwNzAZRz9GrpPZetbcLpKHDUSy3zyvfz+BSv4VF5m8o5wk9TnyrrlFLkZjb6ipw0s0CBQAqACgBGkFPcc8kZIQ49K4rXacFcYS6fv3N/TpSdPLZc0/Ur63uRNbyIrDqUDAfWsCpSpyWJI0sZOi0033aC4J1G4eSGFSd8KufYbetUqrhQjiC3Y5cMOQGdEByw4RtnpTOCUmTKRDcXchg441wGGc06NJZwxjqZZlwdm4r66Fzq4ka2RuJ0Bw8n8o8vU1ehexo+WJFKMp8jMvdGbUNYkmW04fiHPDBGvhUHkoqz+NxHORiglzL2odgrPT9S0E95L8PdTol1HIfw+JcgHoCMj0qOhqsqtOp3jyGOmuhUXsWsmty2ghlSDvyqcB3Vc+Z9POnT1Nxp8SayOVOONzbvv/jG0ELf6beXIuAM91dcJDexAFVKOuTlJKcV8BOBI53QdDSO/xeWvxMG5YfmT39PWr11dtw8jwx1OB3Gn2kWnxYsIhFwj8DDZvnzzWFWqyqv+48lhLGxc/wBRgdh8Xaor+YHCfkRUfhySwnkHHHJnud7nufiNIvJcLzjlwyj0z0piVJvhqxI855mWe2N/auYr20Q42O1bdr7P0b2P/wCeriXZ/wCipWr+C8yi8ehYt+0Om3reKHu3PMKcfYYqvd6NfWW81t3/AO/yOp3FGt+V/Aoa5odvdxG7sJCpxkpnwN6eh+1a2j+0E7eSpXKyuXF+pe/uvr6sqXVlxrMXv2OMr0ZPO5hPnuKgQs0CBQAUAFAoqQDwA3e4H8Nch7QRSrqXdG3pjzTx6lyE8I4VHua5xrc1kzrbRfg+z085k7uNxwALzlY9B6DrWfJKdZLqNctzmL6+zGyoeQ29TXR6ZpFSrJVJx8q+pVubyFJcKeZHSdg+0JUQaPqjRvEFCQO6jwsOQPn6VNrugwhR/E0Fuvze7uUba7cp8MvgdsLCylXurhVaVgWOTg71wk3UjM1OOS3RajtY4kVERQEACnG+Kq1uNSe43iyYfaPSn1GRGVwkdqjvwjmW5j9Kt2lwqccY3ZNTko8zT0idLvT4nBHeBQr+eR51WuISjMZUTjJkk0kSAo8iq2PDk49sGlpJ5yN3M3RtKs47fvoU8c4PeFt8nqKmubipxYzyHOTyUbu3k0iTikiaW1H4WUZKjyNSU6irrZ4ZOpqS2LIsLGWFbu0kk7l1ypUBlHp5j2pHUnF8MluRqo+TKd7eSWFq5t1ibP5gvhz6+VTW9OFSovEb4evfAPONjnnv7PXR3EsItb/kqk+Fz5Z/vXSV9IuNOSubefHT55XNeuPv1KVO6hVfhVFhnP6pp1xp120UiNG6YJQ818j6j1rq9L1aF5SUa3N7ej/73RnXNs6UuKny/Y8QavfW4/ZXBB88Zz/epKns/p1SXFKn9WRq/uEsZKJJJJPM862UklhFN7ipRCzSiBSAFACoAM1WuriFtSdWRLSpOrNRR6XhXJY7muU/D3mpz8Vrb12+Xc2VVo2keEfe42VR860KPs7RS/uzbfpsVp6pP9CPdxfXNwiJLMzIgwq9FHpV+hotjQfFCnv65f7lad7XmsNlc78608LkVcnlyTgDIwcgio6yzBrmOpvDyX/9Wv8A4cQm5lbhAAdnJYAeR6Vmf0Sz41Ucd0senv8AUtq9q8LjnmfSuynaSO/01RdzL8RFs7sQM46n1rzjWNP/AA13Omltnb3GtRfiU4yRoaZcjUb67nQ5t0VYlz15kn71jVYOnBR68yaS4Ukc3qEj6JrTx205CleIoOS55KfOr9JeNRTktyeLU47mTqmty3U4iLMEIGVzkA+lWaNskhMY5G72F1q3uYnsmPdzcRZVJ507XdHrWUlKW8Wtmu5TpV41k3HmuZ1veRNmOTAPUN1Fc7CnLOxLjsfOtV1C60TWbkaRMYrZpM92MFCeux2roKNOFakvE5kqSaWSCfXrm9RsmHJHi/ZKrfbnUzsnSipNbPkwTjnC5mJdx8a8anEq7gjnW9pGou3mqU/8b+n31KV5beJHij+ZEeqavPqZtnuP3sEIiMg5vgnc11NnpdC2hOmt4yecdvRGPVuZyafJoiM0NzFwzIkUwHhmRcBvRgNvnSeFXtJ8VNudPrF7tesW92vR/AXihVXm2l3/AJKfWtVFUVAFilECkAKACgBEVFVoU6ySqRyl+4+FSUHmLwBqRLHIbkVKAUgBSgKkxkAzQBckeSx7PtPEwSSSfZ+HkBz/AFFc9rFGnUUYzRoWlScN4s6rs32zsbfs0J4UkNwWIljYc3wOX8uN643+gXV3c8EMcPfov+mjO6hGHFJ79jAOpve3c8s7kvK3FljzrUv9CnZ0oyp+aPX0Etr6NV8L2ZXEneS+1ZijhGgmUWeSG4YxSMjK5wynBG/nXo1CMLm0h4sU1KK2e/Q5ao5U6suF4w2bsfbPWO5WKd4Z+D8Mjph/qP8ADWNV9lNPnJygnH0T2+pPDUK0fUs2s0Oq2UhBw6/jU/8ArPRh5r59a5e/0+pptdRnvB8muq/0/oa1vcxrw22ZgzOwYSJs8Zw6muk063UFOzrryz3i/wCPXkylc1HLFen05noXayfi8NUq+gXNN5h5l6c/kTU9QpSXm2ZTlxxkg102lTnK0j4nNbfL/hmXcYqq+HkzxWiVRUAFAFilECgAoAVIAUAKgAoFFQIFAoUAGwGT0oA99qL74fT7XTQocqvHttksCN/lXM6jU462OxoUFwxIbOM2+nQQ4AyOM+5/4Faum0uClnuV7iWZHvrWhjJBnBatVLKzjA4cZ+dedahRdC5lTZ01vV8SmpIq3H7+T3rt9LebKl7kYF2sV5+8jq8VyayuJLS4SVGbbZgDjI6iqt7Zwu6Do1OXT0JaNWVKalEU83eXEkqjhDsTw5pKVnGNvGjLfGN/d1XYJVW6jmtskdWyIVKAGgBUAFAFilECgBUAFIAZoAVABQAqACgUKBCexhNxdxxL1O+eWKZUmoQcmOisvBkX8h1TX24f3XFgDyTkPsK5GGa1X3s0n5YmlK/G+eQAwAOlddCKjFRRmyeXki4qdgQs2133Uc0R/DKAPmDkViazpn4tKrBeeP1XYvWVz4T4ZcivMeKVm896vabCVO0pxksNL/ZBcyUq0mjxV4gCgB0AKgB0ABoAVABQBYpRAoAVABQAjzoFCkAKBA60AFABQKXdO8MV7KPxx27FT9qztUk427wT2yzM5/Qx+2uG/MMgGsrS4p1fgWbh4iX3510xnnmgAoAKAHQAqACgB0AFAAaAFQAUoH//2Q==',
                  // Use the actual image URL passed to the constructor
                  width: double.infinity,
                  height: screenHeight / 3,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.6), // Dark overlay instead of blur
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: screenHeight / 5),
                Container(
                  width: screenWidth * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Anime poster with larger height
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                imageUrl,
                                width: screenWidth / 3,
                                height: screenHeight / 5.2,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: screenWidth / 3,
                                    height: screenHeight / 4.3,
                                    color: Colors.grey[800],
                                    child: Icon(
                                      Icons.image,
                                      color: Colors.grey[600],
                                      size: 50,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16, right: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title, // Use the title passed to the constructor
                                    style: FontClass.subtitle.copyWith(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Year: 2023',
                                    style: FontClass.contentText,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Anime Rating: 9.32",
                                    style: FontClass.contentText,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Adventure, Drama, Fantasy',
                                    style: FontClass.contentText,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'AniPlex',
                                    style: FontClass.contentText,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      minimumSize: Size(screenWidth * 0.9, 50),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Play Trailer',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Anime Synopsis',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'During their decade-long quest to defeat the Demon King, the members of the hero\'s party—Himmel himself, the priest Heiter, the dwarf warrior Eisen, and the elven mage Frieren—forge bonds through adventures and battles, creating a...',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ),

                // Trending Anime Section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Trending Anime', style: FontClass.subtitle),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'View All',
                              style: TextStyle(
                                fontFamily: FONT_FAMILY,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: buttonColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 220,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: trendingAnime.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          trendingAnime[index]['imageUrl']!,
                                          width: 120,
                                          height: 160,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container(
                                              width: 120,
                                              height: 160,
                                              color: Colors.grey[800],
                                              child: Icon(
                                                Icons.image,
                                                size: 40,
                                                color: Colors.grey[600],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Positioned(
                                        top: 8,
                                        left: 8,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6,
                                              vertical: 5
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.red.withOpacity(0.9),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.star,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                trendingAnime[index]['rating'] ?? 'N/A',
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    width: 120,
                                    child: Text(
                                      trendingAnime[index]['title']!,
                                      style: FontClass.subtitle,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}