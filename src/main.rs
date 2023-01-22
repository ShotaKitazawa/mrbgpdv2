use std::env;
use std::str::FromStr;

use mrbgpdv2::config::Config;
use mrbgpdv2::peer::Peer;

use tokio::time::{sleep, Duration};
#[tokio::main]
async fn main() {
    tracing_subscriber::fmt::init();
    let config = env::args().skip(1).fold("".to_owned(), |mut acc, s| {
        acc += &(s.to_owned() + " ");
        acc
    });
    let config = config.trim_end();
    let configs = vec![Config::from_str(&config).unwrap()];

    let mut peers: Vec<Peer> = configs.into_iter().map(Peer::new).collect();
    for peer in &mut peers {
        peer.start();
    }

    let mut handles = vec![];
    for mut peer in peers {
        let handle = tokio::spawn(async move {
            loop {
                peer.next().await;
                sleep(Duration::from_secs_f32(0.1)).await;
            }
        });
        handles.push(handle);
    }

    for handle in handles {
        handle.await;
    }
}
